Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8C366816;
	Tue, 21 Jul 2026 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667127; cv=none; b=rx5/iyhCChjBcVbcpUj5+NGKqJM2vfUz3X1yfzcryOcsq6z61p2kcMDU4QdRix94BskWfBZNMIcVxcsVSIasE79CZ5assrTMaeGCKPyG4OCZUI/bYVSkvSTTqsexyzX8xDYEj1AM+ihFnIQ+ujoXg6fYWMxiyOAdJrGmL+sWOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667127; c=relaxed/simple;
	bh=rCTudeeDUdmy5EtSGToENog7lgWQPDmA2jGl9FNIRB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2Ugs63tJXmK+x62ZqGnzIVPXL2SIcWn4uQBpaGA3PZ3xt3n3hCCc5e9aSE+ao/J6pt5mSJlMVINi8xyxfvSn5pTr8cnbGX17NiIrG2fN2/hOkRcjzxMqmSTnwMpUrkhFCh30q8VmrTyZot45cnwbDlH+mX4DISTbRLDHevZLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B0F49140255;
	Tue, 21 Jul 2026 20:52:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 7D11C20025;
	Tue, 21 Jul 2026 20:52:01 +0000 (UTC)
Date: Tue, 21 Jul 2026 16:52:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mark Brown
 <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mukesh Kumar Savaliya
 <mukesh.savaliya@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] soc: qcom: geni-se: trace: Add trace event
 support for GENI SE registers dump
Message-ID: <20260721165220.63d56d38@gandalf.local.home>
In-Reply-To: <20260715-add-tracepoints-for-se-reg-dump-v3-1-0f787f93badd@oss.qualcomm.com>
References: <20260715-add-tracepoints-for-se-reg-dump-v3-0-0f787f93badd@oss.qualcomm.com>
	<20260715-add-tracepoints-for-se-reg-dump-v3-1-0f787f93badd@oss.qualcomm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7D11C20025
X-Stat-Signature: 68pfbk83efr3dts9kt1sdqsq874ydrn8
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19exXdbxlgACwUZljuPvUNUk1FAjHyPGTI=
X-HE-Tag: 1784667121-770416
X-HE-Meta: U2FsdGVkX18JAzOPGCflGUIpUY3u5ICT1CcVLqoeIZzviCZOAL1/TbCrxLMjaRCwt7LGWaWN4fkLTvhJAL0DxGzZ8ad8r10+EM97Hku4dLWhYRr5ehUgf28In1BAs1S/kHKDiuKjYGyfbbnAdCU3JbpLs+EjsmIrL1Y44AzUg2Y4lwpKFqJqQlWFqlv47yVbXNYu3r5z8Ty+qNZDOuzcIIzpGqQnO4yNnMQhEMfY3QcDuuhbFPoXQuZZV9/zzP399shDzgit0xzVM6rb0Cui1D+LCk8fwKJlG92CO/5Gwyfjy6690cE6occvMycQoacLR2BQdTga5q9+ni5LBa2Ub2jvROKaX33YL2x3O1EC/dkwQrAuPVL1Jx34EUzZo3hiaMO5BCn9vCRoQbwXQCeMGmFRJW8yR8ydmB/v6j/oc8dxEB4N36GRyQ==

On Wed, 15 Jul 2026 10:50:47 +0530
Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:

> +	    TP_fast_assign(__assign_str(geni_se_name);
> +		__entry->geni_se_m_cmd0		  = readl(se->base + SE_GENI_M_CMD0);
> +		__entry->geni_se_m_irq_status	  = readl(se->base + SE_GENI_M_IRQ_STATUS);
> +		__entry->geni_se_s_cmd0		  = readl(se->base + SE_GENI_S_CMD0);
> +		__entry->geni_se_s_irq_status	  = readl(se->base + SE_GENI_S_IRQ_STATUS);
> +		__entry->geni_se_status		  = readl(se->base + SE_GENI_STATUS);
> +		__entry->geni_se_ios		  = readl(se->base + SE_GENI_IOS);
> +		__entry->geni_se_m_cmd_ctrl	  = readl(se->base + SE_GENI_M_CMD_CTRL_REG);
> +		__entry->geni_se_m_cmd_err	  = readl(se->base + M_CMD_ERR_STATUS);
> +		__entry->geni_se_m_fw_err	  = readl(se->base + M_FW_ERR_STATUS);
> +		__entry->geni_se_tx_fifo_status	  = readl(se->base + SE_GENI_TX_FIFO_STATUS);
> +		__entry->geni_se_rx_fifo_status	  = readl(se->base + SE_GENI_RX_FIFO_STATUS);
> +		__entry->geni_se_tx_watermark	  = readl(se->base + SE_GENI_TX_WATERMARK_REG);
> +		__entry->geni_se_rx_watermark	  = readl(se->base + SE_GENI_RX_WATERMARK_REG);
> +		__entry->geni_se_rx_watermark_rfr = readl(se->base + SE_GENI_RX_RFR_WATERMARK_REG);
> +		__entry->geni_se_m_gp_length	  = readl(se->base + SE_GENI_M_GP_LENGTH);
> +		__entry->geni_se_s_gp_length	  = readl(se->base + SE_GENI_S_GP_LENGTH);
> +		__entry->geni_se_dma_tx_irq	  = readl(se->base + SE_DMA_TX_IRQ_STAT);
> +		__entry->geni_se_dma_rx_irq	  = readl(se->base + SE_DMA_RX_IRQ_STAT);
> +		__entry->geni_se_dma_tx_irq_en	  = readl(se->base + SE_DMA_TX_IRQ_EN);
> +		__entry->geni_se_dma_rx_irq_en	  = readl(se->base + SE_DMA_RX_IRQ_EN);
> +		__entry->geni_se_dma_rx_len	  = readl(se->base + SE_DMA_RX_LEN);
> +		__entry->geni_se_dma_rx_len_in	  = readl(se->base + SE_DMA_RX_LEN_IN);
> +		__entry->geni_se_dma_tx_len	  = readl(se->base + SE_DMA_TX_LEN);
> +		__entry->geni_se_dma_tx_len_in	  = readl(se->base + SE_DMA_TX_LEN_IN);
> +		__entry->geni_se_dma_tx_ptr_l	  = readl(se->base + SE_DMA_TX_PTR_L);
> +		__entry->geni_se_dma_tx_ptr_h	  = readl(se->base + SE_DMA_TX_PTR_H);
> +		__entry->geni_se_dma_rx_ptr_l	  = readl(se->base + SE_DMA_RX_PTR_L);
> +		__entry->geni_se_dma_rx_ptr_h	  = readl(se->base + SE_DMA_RX_PTR_H);
> +		__entry->geni_se_dma_tx_attr	  = readl(se->base + SE_DMA_TX_ATTR);
> +		__entry->geni_se_dma_tx_max_burst = readl(se->base + SE_DMA_TX_MAX_BURST);
> +		__entry->geni_se_dma_rx_attr	  = readl(se->base + SE_DMA_RX_ATTR);
> +		__entry->geni_se_dma_rx_max_burst = readl(se->base + SE_DMA_RX_MAX_BURST);
> +		__entry->geni_se_dma_if_en	  = readl(se->base + SE_DMA_IF_EN);
> +		__entry->geni_se_dma_if_en_ro	  = readl(se->base + DMA_IF_EN_RO);
> +		__entry->geni_se_dma_general_cfg  = readl(se->base + DMA_GENERAL_CFG);
> +		__entry->geni_se_dma_qsb_trans_cfg = readl(se->base + SE_DMA_QSB_TRANS_CFG);
> +		__entry->geni_se_dma_dbg	  = readl(se->base + SE_DMA_DEBUG_REG0);
> +		__entry->geni_se_m_irq_en	  = readl(se->base + SE_GENI_M_IRQ_EN);
> +		__entry->geni_se_s_irq_en	  = readl(se->base + SE_GENI_S_IRQ_EN);
> +		__entry->geni_se_gsi_event_en	  = readl(se->base + SE_GSI_EVENT_EN);
> +		__entry->geni_se_irq_en		  = readl(se->base + SE_IRQ_EN);
> +		__entry->geni_se_ser_m_clk_cfg	  = readl(se->base + GENI_SER_M_CLK_CFG);
> +		__entry->geni_se_ser_s_clk_cfg	  = readl(se->base + GENI_SER_S_CLK_CFG);
> +		__entry->geni_se_general_cfg	  = readl(se->base + GENI_GENERAL_CFG);
> +		__entry->geni_se_output_ctrl	  = readl(se->base + GENI_OUTPUT_CTRL);
> +		__entry->geni_se_clk_ctrl_ro	  = readl(se->base + GENI_CLK_CTRL_RO);
> +		__entry->geni_se_fifo_if_disable  = readl(se->base + GENI_IF_DISABLE_RO);
> +		__entry->geni_se_fw_multilock_msa = readl(se->base + GENI_FW_MULTILOCK_MSA_RO);
> +		__entry->geni_se_clk_sel	  = readl(se->base + SE_GENI_CLK_SEL);
> +	    ),
> +

I think this is the first time I've seen a trace event read IO directly.
Hmm, will this have any side effects?

If not, I have no problem with this:

 Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
