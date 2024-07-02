Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354D6E5ED;
	Tue,  2 Jul 2024 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949083; cv=none; b=h/Va7rvXYFOnaHyZsizhqTpve4FF/g2jbMsrphqCeomWXwJKWWtPbgCjQ8HH4WpiXTEyAQqsJ/An4WdbagHxzZ8L2sqfWxo0BwB6EX+H96q/6kr+G0CXpHetqlLuELPl5qPoR33S5lvUPsqUTc3bvf1ge13p69WTWtd6GLJkSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949083; c=relaxed/simple;
	bh=kGS0pCNSMAYhJglJcLwoEstVCzeb6m4S+jRAB33T97s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAkGb3zItkdu3dFA9z7PBWR7cF/97VgfDD5EI8ae9KwU89WHpXADLZH2TMxML62OX7QyAVLmAwgitLZubWqmxeS/e9/xRXIGB1NPh4PdbEazTzZbDln6WxXjw3ThHvKla1StwMCsdT00Nnrf8ClOJukPhnlTgzojOx0rKqCrjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KNtW8Ihl; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KNtW8Ihl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719949079;
	bh=kGS0pCNSMAYhJglJcLwoEstVCzeb6m4S+jRAB33T97s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KNtW8IhlkHVn6APa0E0M8hYmJKTxOIE4iXNfmwax66c3V5sgGP1LN612FsdIS9DVY
	 yc64/qSH3X/ADZm8wKmy/VlIxyzzyK+PYecMwzCR6kvdRSq98AQb0LpJm94zCwMVs5
	 4BPLr9Hl335ZOIjZn4URmouzAsEr4jxV7JV7NYORgVHl/ORwpgCbOcLHKairX2yrGz
	 RelZ1CgmZW9lqaKYe1z+tb29EtOhLICrSYqAfxpZGQgjZ+P5Z3l5L3mJrTvOYPi4+u
	 fdNe/WvISb8VW7fPn3AD0FR2Mih6CPOR1oQwiraQv+w+0LCY+ETKr1bd6H+wva/oxi
	 xtXDFOIQmGXqw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WDCqq3jSxz18VM;
	Tue,  2 Jul 2024 15:37:59 -0400 (EDT)
Message-ID: <2227082b-381d-40bf-a106-eb789e433215@efficios.com>
Date: Tue, 2 Jul 2024 15:38:10 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Have memmapped ring buffer use ioctl of "R"
 range 0x20-2F
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, "Dmitry V. Levin"
 <ldv@strace.io>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20240702153354.367861db@rorschach.local.home>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240702153354.367861db@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-02 15:33, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> To prevent conflicts with other ioctl numbers to allow strace to have an
> idea of what is happening, add the rang of ioctls for the trace buffer
> mapping from _IO("T", 0x1) to the range of "R" 0x20 - 0x2F.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20240630105322.GA17573@altlinux.org/
> 
> Reported-by: "Dmitry V. Levin" <ldv@strace.io>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
>   include/uapi/linux/trace_mmap.h                    | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a141e8e65c5d..9a97030c6c8d 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -186,6 +186,7 @@ Code  Seq#    Include File                                           Comments
>   'Q'   all    linux/soundcard.h
>   'R'   00-1F  linux/random.h                                          conflict!
>   'R'   01     linux/rfkill.h                                          conflict!
> +'R'   20-2F  linux/trace_mmap.h
>   'R'   C0-DF  net/bluetooth/rfcomm.h
>   'R'   E0     uapi/linux/fsl_mc.h
>   'S'   all    linux/cdrom.h                                           conflict!
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> index bd1066754220..c102ef35d11e 100644
> --- a/include/uapi/linux/trace_mmap.h
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -43,6 +43,6 @@ struct trace_buffer_meta {
>   	__u64	Reserved2;
>   };
>   
> -#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
> +#define TRACE_MMAP_IOCTL_GET_READER		_IO('R', 0x20)
>   
>   #endif /* _TRACE_MMAP_H_ */

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

