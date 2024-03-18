Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B6107B3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727366; cv=none; b=pHBV0kjpQwODEUU/Afe7uCYtV1P9waGQJ75F3OqZSBRcItA1tOlbOp+ae+UFGR7ItiTej0bURS/RF/feG0WRcYTKQo0/5KHbVVC/jNfu7etdh7KPpAgQpJYRFSsIoHkSYoog+AKtz7/6TjAKiOlxobAKrdxbhxWJvc6A/PczTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727366; c=relaxed/simple;
	bh=cwQvNCEPhdKlimrOAhfEe/MamQsNHHK66iPQYtUyy8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DBPimzDWIfuhr0hktUSCkh6W0Nd8Mmw6t1s0081HMFRZOa8ISQmrZElsHbFSfgDgDIz9VIAJs/IRQi9f9160B+0+A8yMg+qgb4b3p/nRu37k0cPpEG9MJhu538Brj8EtQsx7wRY7Mmn9ynxZ4rX+VL78FoAJaNTrI9es0XU/snE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nios/d1Y; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nios/d1Y"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6c18e9635so1053219b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710727363; x=1711332163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRLUIM3R69u5cP86Pofeov2WFNQje7z1HVd/36/zkl0=;
        b=Nios/d1YIp/OLamPj8LPAtWIGMsGD+GHKBztU7mivdkFhV/MRsXh8rcK5sVGS6Ehm7
         weKjFX8N9bmIIqnxMnYoNZhd1FRlNbmROow0+3kbf1U98UdZeEZGS2WyaWKwQkjqpvn7
         0vMCtqUdS95Bz2c5be2CfcmiddcgrdsT7/vsPZkxi9wutA5xDsWR0Qp+v/w/AZpv4aK1
         +NNt4PrqJMip1xAk7GNoMg8LAz5XdETvG3jfbes+jUg4hz4qXc9NcTGZ+OpdibVyfy1W
         tsvzdoRyrlTeSMRisdMBvBeGlefeI+3E8/FwCTIy5M1jJG+cdUfzYAcK6xeWz+4ZOYw3
         PzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710727363; x=1711332163;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRLUIM3R69u5cP86Pofeov2WFNQje7z1HVd/36/zkl0=;
        b=qE7kiW+Z/QTR9OIIufNGaUXL/xx+Wif3njrwv2XGoJiTS7lQybv5yELHqIOwMDQ3d3
         HNgkKmHxb/plEzvJic1ReEKCSnqWcrY30sHADSrcjBKN0DaH4MFXp9WDnVv6tfVPJz0J
         CfhTnPlXRk+w+ZIUoxg3d61flX9kU4Bh05QzZTAwpVHanLuM3JS+v5KYDL7XURiZYtaU
         2J+mIxgVDOvHtkzJFPXatuO9+rgnjtKM5hqBqcrPPSyme9j75+e6Ew0Y295Xqzi2U4l+
         UxVpb4lBl+mc9MsCL3S2MBLaVylZxmHrR+KaVL2cMZX4DE4ZpnyoeHsWLhYplxOlXPRH
         i2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUqg88b0Mp6p5znpb6AaJjriCvoeLvYu1KXTdyzHJh6P4kGbLMs1islz4AXpL56uo/BeFPNLz0vix+IEko8jF4yQ+HQtNQub42SsSDTu/kRw7ES
X-Gm-Message-State: AOJu0YykDVpATssuMYohJNQZcU3ND09SmVwEGkjOYve7cJf+j2Z9oayD
	rh1jatYSUDBY6DGmp5dc+hIjqHRu7TIcYjPInK5qeW1fHEJgM1yqTZwPk+CxVAo=
X-Google-Smtp-Source: AGHT+IF1cTU02AMNgA6RxkSPhBZHg6UnwaMDic1y4LysiED4LdAsG8A360oBIrD3QhtLaq/7udQyiQ==
X-Received: by 2002:a05:6a20:8e04:b0:1a3:69e9:46bd with SMTP id y4-20020a056a208e0400b001a369e946bdmr291183pzj.5.1710727362726;
        Sun, 17 Mar 2024 19:02:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id st6-20020a17090b1fc600b0029bbdc920besm6386959pjb.44.2024.03.17.19.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 19:02:42 -0700 (PDT)
Message-ID: <30d89cd2-7748-4285-a1c5-e1724bf5ec31@kernel.dk>
Date: Sun, 17 Mar 2024 20:02:40 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KASAN: null-ptr-deref Write in tctx_task_work_run
Content-Language: en-US
To: Ubisectech Sirius <bugreport@ubisectech.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <4fb30f6c-cd4c-4fcc-97ad-7132a503f7f7.bugreport@ubisectech.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4fb30f6c-cd4c-4fcc-97ad-7132a503f7f7.bugreport@ubisectech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/24 6:59 PM, Ubisectech Sirius wrote:
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.8.0-ge5e038b7ae9d. Attached to the email were a POC file of the issue.
> 
> Stack dump:
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> BUG: KASAN: null-ptr-deref in llist_del_all include/linux/llist.h:266 [inline]
> BUG: KASAN: null-ptr-deref in tctx_task_work_run+0x7d/0x330 io_uring/io_uring.c:1267
> Write of size 8 at addr 00000000000001c0 by task iou-sqp-215603/215604
> 
> CPU: 0 PID: 215604 Comm: iou-sqp-215603 Not tainted 6.8.0-ge5e038b7ae9d #40
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:114
>  kasan_report+0xbd/0xf0 mm/kasan/report.c:601
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0xf4/0x1a0 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  llist_del_all include/linux/llist.h:266 [inline]
>  tctx_task_work_run+0x7d/0x330 io_uring/io_uring.c:1267
>  io_sq_tw+0x12a/0x1d0 io_uring/sqpoll.c:245
>  io_sq_thread+0x8d7/0x18a0 io_uring/sqpoll.c:308
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> ==================================================================
> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> CPU: 0 PID: 215604 Comm: iou-sqp-215603 Not tainted 6.8.0-ge5e038b7ae9d #40
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014

I think you snipped the fault injection that came before this. It looks
like an allocation failure, so we don't get tsk->io_uring setup for the
SQPOLL thread. Not a great way to handle this, but can you try the
below? Would be nicer if we could just prune the task rather than wake
it and have it error.

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 363052b4ea76..db7b0fdfe1cb 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -274,6 +274,10 @@ static int io_sq_thread(void *data)
 	char buf[TASK_COMM_LEN];
 	DEFINE_WAIT(wait);
 
+	/* offload context creation failed, just exit */
+	if (!current->io_uring) {
+		goto err_out;
+
 	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
 	set_task_comm(current, buf);
 
@@ -371,7 +375,7 @@ static int io_sq_thread(void *data)
 		atomic_or(IORING_SQ_NEED_WAKEUP, &ctx->rings->sq_flags);
 	io_run_task_work();
 	mutex_unlock(&sqd->lock);
-
+err_out:
 	complete(&sqd->exited);
 	do_exit(0);
 }

-- 
Jens Axboe

