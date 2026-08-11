Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB63C13EE;
	Tue, 11 Aug 2026 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478669; cv=none; b=CKT9ZhKS4/C/tKEu59Ijkdp65r6Lwf71ZQcJ/0drtpirHXBoyVi1K4eU4+0JrWDAy9k8RwyO73Q3N7khv+RwG5rllxTi6wNDCQzxdAmrAV8FzAFdtZzmRuea+6cTC8rr3eMYF5I7AsrJZLWF4It/FRZAUlEuJVMGSpSlinxojeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478669; c=relaxed/simple;
	bh=fH6aamd7E7QkoyrAVrHKxYghruksEW/jQTj3a7R818g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahwD2TNw1Y+eslZuTQkGU/u61KSArhrVNovAYIvvSMSEqbrg3q+4nq1TPSlBWNHcV7UUwzOUnbmi+H82D298kJCwBVDiLOHez2inHmsFh9Gw35SmUulyzsTUeMTvq3Zk1nZmCBzGQ4E++l97LWI3PrRFBPWSCLVg9WhVHUA8EgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id DFDAE1C0118;
	Tue, 11 Aug 2026 20:04:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id F310217;
	Tue, 11 Aug 2026 20:04:16 +0000 (UTC)
Date: Tue, 11 Aug 2026 16:04:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Baolin Liu <liubaolin12138@163.com>
Cc: almaz.alexandrovich@paragon-software.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 liubaolin12138@gmail.com, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v3 v3 5/7] ntfs3: add allocation tracepoints
Message-ID: <20260811160424.09bfd609@gandalf.local.home>
In-Reply-To: <20260807010354.2277156-6-liubaolin12138@163.com>
References: <20260807010354.2277156-1-liubaolin12138@163.com>
	<20260807010354.2277156-6-liubaolin12138@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: F310217
X-Stat-Signature: ip6yhfz1joa7zre51ntn4uat5ukrni58
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+P8t6Qx9dwlZtf/bFeQJeuRgfciHZARVI=
X-HE-Tag: 1786478656-628399
X-HE-Meta: U2FsdGVkX189ecoIMJvPdWhF+1DjKZ6BvmarL45Vr0+1t0IU0k8n4jD9UcapBS4XCo691Liw0hUzJaw30gAE6GbqUFzVs+k5IkGc5MKxNSCQL+OSEGKXPgEiW2sZUYBNNbYzXHJu3U2ZlbJ88Zz4dX9chUJagsTzivESe1MQgMjDj/mc6oV9hBsESGYaWBjmMYsQ0dA8wS3PReU4fGEZs/DGmxa3hlJOhr/BLSE7T5rpgvfYegJ4hZkvp5nvzgfNF/qxRC5mxVeyK2BldWBLF3s04/eDVlRx9vp8tvjFTmDO73251+XRbn21xxv0A+UzMDdnTPVBOBdoXTGSXUsdKRFppCnb0N5T

On Fri,  7 Aug 2026 09:03:52 +0800
Baolin Liu <liubaolin12138@163.com> wrote:

> @@ -960,6 +966,9 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
>  	if (res)
>  		*res = NULL;
>  
> +	trace_ntfs3_attr_data_get_block(&ni->vfs_inode, vcn, clen,
> +					 new != NULL, zero, no_da);

Hmm, why not just pass new in. It looks like this is the only place that
calls this tracepoint, right?


> +TRACE_EVENT(ntfs3_attr_data_get_block,
> +	TP_PROTO(struct inode *inode, u64 vcn, u64 clen, bool create,
> +		 bool zero, bool no_da),
> +	TP_ARGS(inode, vcn, clen, create, zero, no_da),
> +	TP_STRUCT__entry(
> +		__field(u64, vcn)
> +		__field(u64, clen)
> +		__field(unsigned long, ino)
> +		__field(dev_t, dev)
> +		__field(bool, create)
> +		__field(bool, zero)
> +		__field(bool, no_da)
> +	),
> +	TP_fast_assign(
> +		__entry->vcn = vcn;
> +		__entry->clen = clen;
> +		__entry->ino = inode->i_ino;
> +		__entry->dev = inode->i_sb->s_dev;
> +		__entry->create = create;

Then you can have this be:

		__entry->create = new != NULL;

and keep that logic out of the code and out of line in the trace event.

-- Steve

> +		__entry->zero = zero;
> +		__entry->no_da = no_da;
> +	),
> +	TP_printk("dev=(%d,%d) ino=%lu vcn=%llu clen=%llu create=%d zero=%d no_da=%d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
> +		  __entry->vcn, __entry->clen, __entry->create,
> +		  __entry->zero, __entry->no_da)
> +);
> +
>  #endif /* _TRACE_NTFS3_H */
>  
>  #include <trace/define_trace.h>
