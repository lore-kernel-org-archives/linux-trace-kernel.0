Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBA3009F0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179710; cv=none; b=Yba8VrIjQouqWxhkoXuCc9VIFkftmlaouQbcpwS+lMPQUQ6DCGBhIZ4sE0DbN6Y0uzxkZj/3H+3xLno8WCHzcnjcLP+FoX6v3YQvMW7qMDlooD4aqOxLxIC/QzyYPIr3n1xUmkvrl5qiZkMW8J+J6bwoCdbPiCPjAI0YA1qkSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179710; c=relaxed/simple;
	bh=7GlNJhry7TThYwVtorBJU7ypkucLCF+YWV8hYGJ/q2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxzowOF7Bn/TAJIw7C75ncqS8Tsw/bJDRNASZ5WdM36+gFXwATWWtQyRI6Y5BpdJQSGyurMJg2PFUB+oCuEw48DFYRPBaH87KzVQLP44N85/HKl9mZVHwUj7W8GQieMX261HQBg/BEaHM1oHsCWU2QbRSnbwCAWwE4H8rai/YG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=oyS707iJ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="oyS707iJ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70a88db0416so9868696d6.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755179706; x=1755784506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlALy2xhseF+yQTX6QJcUoYBFvoxQUQwSPoAaHJPRr8=;
        b=oyS707iJRfzFAambHeVKgYCiTzl8mlaTZxUTbsH4jTXqgmG6WUDBo3AXCd8HEquT8A
         sdMbK1rC2uqeICnQ8yfdJI0VTQt0xmp6ra7IKjd9c+siVXEVhhX/so2j+xeI4lpTRBHz
         ZuC+Wu8TeP1l7g5LnKF0UplstztZXGyLqpUQCTZC5RDpRvBghlF08sTr9g4Iugp+b9Lq
         Z2gb61x0aeEtVGAK+7ysTcT3BVwjoamoKnDQnyZYNRswRtMiwzyxsdKxZeNy20V82KME
         oQp8iuN+LCgyGkVVWVUPDBiBp5PnX850tQ3VQhqGd7Z60jwxpf8blJpB+W498/Jlwp0S
         vw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179706; x=1755784506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlALy2xhseF+yQTX6QJcUoYBFvoxQUQwSPoAaHJPRr8=;
        b=dQPz6CT7wxRIohnOt6an1smY+L4d/aCRnGElU9ByMtx8tgkyfVGJbWQJ4oDVYKr8gT
         UU6rDMx4I3BjgL7R0Y5s0ftn/0NpepSYJZ4dMces+soiZsnFkwpS1qGAoDa9wbEW5oqs
         x2m6iCp+2pHP6ljDgv57YSC1ILRISnO2ZP8SYyNulaNlpnNYLRBUQD7z4AJadMRZAjna
         tDRtYqdE7une7PQAeWh4RrEt7DXD+EdS2jO9JqYrilyEfiVaEKe/PvOi8TgGFqaBSm0x
         AFT2opmAx2MFX1F1VOGChEZRR4Z5xkrecNv3zcNK2pDYt8n/2FZFBULJRsB/BCW6LSqa
         m39Q==
X-Forwarded-Encrypted: i=1; AJvYcCX59q7Rbna3gE6TVbLH0ISmwijznoTQ2HHtup/JrKXLEnmuui5vKDU1u6dTRd/Z/Yo1EplOL3AH5VSCe+GWYYbf3Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmI3rYtMm5Y4v94wddK3X9t0itY8GwTBADrJBsdjuXvKYQjcSt
	pThmUX/Kb518R7jc2B3AYtaC7hpngAVzwY0tRy6rPGWUSFWhwOo+Zm2N2KolTjUxItw=
X-Gm-Gg: ASbGncsDOwKm12j13R6FYxK3MJWawaiQ+dpTP09ijTw6reTAfUCJdp0ThwY5nI7S7gT
	LCaQ9n+VqM9HhNBuTcJWLZqF+7S1h3WUcB+r3n0Bn/nX+R6bzFZ/gJ3LiTFaduUNDYVmGCMsZfI
	BUNxapg0gtW55XlK/0XjKjZJHrpuFjuNUCzZ3YpmwVfkkYiHy8s8JbXhWFGfTa98dMyliHkDF78
	6Uq2NgQrB9HMzdEbdlaTxWQGuNCTWZdEynFS84wfAN+viRps6IBXRgd95Jijmcf2lpD40Hx101K
	Fk9F6JK5YxC0yU5ftq6K00LVC0K4Bil7JvzEf7L1ycRBvhmhiutAr6/ucugUobCQh8b9uMslAi+
	Jpa7WFvepPMSuFAdh0Y+ZOQ==
X-Google-Smtp-Source: AGHT+IFL9mfmhIOtoP3f48wEW/B6LYJ+F/aJttG1hYQa0kKnXgEyKk/hQne+aXocVTXmvmyjVO0Ehw==
X-Received: by 2002:a05:6214:c24:b0:709:e095:128f with SMTP id 6a1803df08f44-70af5d0539emr51369616d6.25.1755179706213;
        Thu, 14 Aug 2025 06:55:06 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70af5c0d80fsm12601116d6.80.2025.08.14.06.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:55:05 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:55:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: rostedt@goodmis.org, surenb@google.com, peterz@infradead.org,
	mingo@redhat.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, andrii@kernel.org, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	yuming.han@unisoc.com, ke.wang@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [RFC PATCH] sched: psi: Add psi events trace point
Message-ID: <20250814135501.GD115258@cmpxchg.org>
References: <20250814070719.865-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814070719.865-1-xuewen.yan@unisoc.com>

On Thu, Aug 14, 2025 at 03:07:19PM +0800, Xuewen Yan wrote:
> Add trace point to psi triggers. This is useful to
> observe the psi events in the kernel space.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

Can you elaborate on a situation in which you would use this?

> ---
>  include/trace/events/sched.h | 5 +++++
>  kernel/sched/psi.c           | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..c23cb2bc76fd 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -896,6 +896,11 @@ DECLARE_TRACE(sched_set_need_resched,
>  	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
>  	TP_ARGS(tsk, cpu, tif));
>  
> +struct psi_trigger *t

Missing ;

> +DECLARE_TRACE(psi_event,
> +	TP_PROTO(struct psi_trigger *t),
> +	TP_ARGS(t));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
