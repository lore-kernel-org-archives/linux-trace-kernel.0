Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3B4B1E7D;
	Wed,  7 May 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633277; cv=none; b=Z2aFEWl7lX6E1YGfBig/10gyAMTn54KMGjdjiVFVjOnyJ/s3SdoLc/ObZJjOhUVh2NLKu+MruH2eG1EX9sxGVJmrRrOuYOKs+DmV3RniW3b1iHIAonrR9umwkT71e4EL8m/DrURMmU3FwxNlYsSOhNYrUXdlqRi++iXV6cG19KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633277; c=relaxed/simple;
	bh=9lwfyyEGkoBX6ds3JiV79GSpr/yBVbLN0v8+3hr7bkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrsD9Q5dHtRAQIh5M8Oh0pWpLlcpq9OzZhlO09Y/fB6IepeMoGcR7cb7XSioeqT3VF0Nz7XdFEA8tHjfz8qY0z8KvyFNz/p4fEmMvkTW1SmyvHKy1VR58cbIxbpfhThDm7kbRnRljL1uO2Xp1/e8satvOtDK5wrqb+woHU+ynvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7A5C4CEE2;
	Wed,  7 May 2025 15:54:36 +0000 (UTC)
Date: Wed, 7 May 2025 11:54:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kassey Li <quic_yingangl@quicinc.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: trace: change the rtn log in hex format
Message-ID: <20250507115446.55e09c7f@gandalf.local.home>
In-Reply-To: <20250507070714.2387602-1-quic_yingangl@quicinc.com>
References: <20250507070714.2387602-1-quic_yingangl@quicinc.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 May 2025 15:07:14 +0800
Kassey Li <quic_yingangl@quicinc.com> wrote:


This patch is fine with me, but it needs to go through the scsi maintainers.

I don't see them Cc'd.

-- Steve


> In default it showed rtn in decimal.
> 
> kworker/3:1H-183 [003] ....  51.035474: scsi_dispatch_cmd_error: host_no=0 channel=0 id=0 lun=4 data_sgl=1  prot_sgl=0 prot_op=SCSI_PROT_NORMAL cmnd=(READ_10 lba=3907214  txlen=1 protect=0 raw=28 00 00 3b 9e 8e 00 00 01 00) rtn=4181
> 
> In source code we define these possible value as hexadecimal:
> 
> include/scsi/scsi.h
> 
> SCSI_MLQUEUE_HOST_BUSY   0x1055
> SCSI_MLQUEUE_DEVICE_BUSY 0x1056
> SCSI_MLQUEUE_EH_RETRY    0x1057
> SCSI_MLQUEUE_TARGET_BUSY 0x1058
> 
> This change converts the rtn in hexadecimal.
> 
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  include/trace/events/scsi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/scsi.h b/include/trace/events/scsi.h
> index bf6cc98d9122..a4c089ac834c 100644
> --- a/include/trace/events/scsi.h
> +++ b/include/trace/events/scsi.h
> @@ -240,7 +240,7 @@ TRACE_EVENT(scsi_dispatch_cmd_error,
>  
>  	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u prot_sgl=%u" \
>  		  " prot_op=%s driver_tag=%d scheduler_tag=%d cmnd=(%s %s raw=%s)" \
> -		  " rtn=%d",
> +		  " rtn=0x%x",
>  		  __entry->host_no, __entry->channel, __entry->id,
>  		  __entry->lun, __entry->data_sglen, __entry->prot_sglen,
>  		  show_prot_op_name(__entry->prot_op), __entry->driver_tag,

