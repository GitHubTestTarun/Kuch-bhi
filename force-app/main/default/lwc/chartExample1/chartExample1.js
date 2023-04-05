import { LightningElement} from 'lwc';
import chartjs from '@salesforce/resourceUrl/chartjs';
import ChartJsDataLablePlugins from '@salesforce/resourceUrl/ChartJsDataLablePlugins';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ChartExample1 extends LightningElement {
    
     
    isChartJsInitialized;
    chart;
    labels = [];
    datasetValues = [];
    config;

    async connectedCallback() {
        if (this.isChartJsInitialized) {
            return;
        }
        this.isChartJsInitialized = true;

        await Promise.all([
            loadScript(this, chartjs+'/chart.min/chart.min.js'),
            
        ]).then((data) => {
            console.log('data === ',data);
            const ctx = this.template.querySelector('canvas.linechart').getContext('2d');
            this.chart = new window.Chart(ctx, this.setConfig());
            this.chart.canvas.parentNode.style.height = '100%';
            this.chart.canvas.parentNode.style.width = '100%';
        }).catch((error) => {
            console.log('inside catch of loadScript error is ', error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading ChartJS',
                    message: error,
                    variant: 'error',
                }),
            );
        });

        await Promise.all([
            loadScript(this, ChartJsDataLablePlugins + '/chartjs-plugin-datalabels.min/chartjs-plugin-datalabels.min.js'),
        ])
        .then((result) => {
            console.log('datalabels loaded successfully inside Connected callback and result is ', result);
        })
        .catch((error)=>{
            console.log('error in dataLables inside redered callback ', error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading DataLabels ChartJS',
                    message: error,
                    variant: 'error',
                }),
            );
        });
    }

    setConfig() {

        this.config = {
            type: 'bar',
            data: {
                labels: ['A', 'B', 'c'],
                datasets: [
                        
                        {label: 'Fully Rounded',
                    
                            data: [0,20,30,40,50], 
                            backgroundColor: 'red'
                        },
                        {label: 'Fully',
                    
                            data: [30,22,30,40,50], 
                            backgroundColor: 'red'
                        }
                ]
            },
            options: {
                
                plugins: {
                    datalabels: {
                        color: "black",
                        labels: {
                            title: {
                                font: {
                                    weight: "bold"
                                }
                            }
                        }
                    }
                }
            }
        };

        return this.config;
    }
}