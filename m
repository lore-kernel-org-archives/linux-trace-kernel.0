Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206463271F0
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263966; cv=none; b=IjAlnMeNB4OJlMepGLCDCDj8DDA3v2P0djQWzlsOVV7JYbJG3NVu34fyz4QmBF1yM27XmRafpxQZBBDJaY9aaMOxa6SFbDD6gJ1t04QMEAEhSDKBVI0rXcVCgcR8YLNCEkmntbBVCXlnpJR1I+atqN3UiiHDErnoIXDGCap2KZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263966; c=relaxed/simple;
	bh=6ox1zLtoIs3WHKjGHBqzO0nCO9DbDq7atxZ/hCyqdAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8HSI3uTOrfXMImwS19g7PwTdns53HLca2Vm3BIFD/72f3kDbv+SHO+y6o2wVQ5oCSGOcl+UJxnGXXPQeWNPtem4fJYakDxv468yQuTUjeCwtZ/kzUeTi5NsozXMy0Wmjt0nbCp1GjYKCeuMttRs6GNeQK9C4V5dRurjipdcQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdXPn4Bi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdXPn4Bi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762263963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
	b=cdXPn4BiheZehvRQV5G5TL3atlV5pq+uCVrZVVoNrOrRag88PHqIG8ii98twd5ioLWgfg6
	nScOjySFscMDOM7VBmOCunZbG7Ujnb4b2+iJgv1gr9pCLhMNw0/AQRPTAG69367iVdMlqb
	N04lWcdlzYmbbL8e5m5JPgCWM2iVgS4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-OOonYaFtN4eoxQWrjj_FHA-1; Tue, 04 Nov 2025 08:46:02 -0500
X-MC-Unique: OOonYaFtN4eoxQWrjj_FHA-1
X-Mimecast-MFC-AGG-ID: OOonYaFtN4eoxQWrjj_FHA_1762263961
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so4301664f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263960; x=1762868760;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
        b=BMC+yeEXmQ/XSBAiJe51t9RIki4nBFSkOmt/Jkr7xVF2oBxFOxZxMEwfGmoNzbmzIj
         KzBN+AjXXwDU7duruupXomIYkG3RxHIdzWPGGNWkWgi2CHkU8mzcnxUrOf4IfjXN4RnA
         4ACjTdul/W48UKkMa8Fge0TZJTC5vxN1DYp6CU5BRAv0XAr7dgl3fkvVYGW4cdxVqYDE
         jqVlehIgCxeVZqeGC9jP28zWNDdoQDPG8LDFqnlk9dLZFq/UpcB/t0DTL9QZTtCF0xNS
         RJm/ZdwsEDtDm/sAluFfsE4hMefWMHdNbQeO064rCjCQxGgaPHT9MMkc1xaV+Sfx/qCl
         ksGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiEMBQ4Do0VmZgVXtQQcvMQ2YI8DVWJJBamkNa5On6Q3jfi3+Nx4JdrreIYwR93gYS8o6C6Mj7GJkR6qmBH3YoZKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9948mGn2uQCsFV0jtBzLyn7ChTkeKONcCsVF8wp85XiqZp+1W
	O8V2v1Ao+TtulxCKPRJHRx5F/DpcP2JalmM3+mGhU7TVxUnOhPNye6PXWDvBVrE3G0vxiq20vPr
	E8htZhEhSZRHSKHcZyyhvHM5aMZUF45vyRk+AIc5rnqGMfMq2UPVSt0TnkcyiAfM0+zl9t9bQPc
	Yaec+fCeMOc/rSdpFg83tQ800Px45gV0MNYiZAuLO+NFCQvBwn71fBpQyIFw==
X-Gm-Gg: ASbGncuvd9ZbBOQ3xiZejdghGar8v18WMjO5Oa8hmrETG3I77W04h6weg32WBBeV6mL
	hI8CbQCPkxBQi3ew2mcfy8ZV5VkTcVjiEb4Mv4tJu62JcXhhuCRUAlIFpg8OaGS5xdrLq7ybw6C
	QZW6FXcLKkSaC8P2aRAqnTmXLDvJ8IueDl7FM/0m3IG4liRE7ii3XhSz2f2UnTFHHFgaFeiCADq
	LcH4zJ8cTxS/TTUPDfXlQpZ8LxA5jTbzi6heLLdQUEpSU4zdxPO5kadk0BRTYD9E0j9uDVSNBE1
	aCzA/XzkfAonkZXgZlOt1diO3vImFsMrGtlL/B8AbKmxzOA6AM5pyFCoxX6fbAYGvyAIlzZWOYX
	/T+XEe/k3gmo5KgErw60bAUXFXRfPiakWza4=
X-Received: by 2002:a05:6000:22c9:b0:429:d11b:9ec4 with SMTP id ffacd0b85a97d-429d11ba360mr6284657f8f.41.1762263959874;
        Tue, 04 Nov 2025 05:45:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRnKz3y+r5XoY3ls/nBZPt8sht5PzwdeS+jf9m1q52xASXswgB53muxrTyL7Mvrv/sZwgkKw==
X-Received: by 2002:a05:6000:22c9:b0:429:d11b:9ec4 with SMTP id ffacd0b85a97d-429d11ba360mr6284574f8f.41.1762263959010;
        Tue, 04 Nov 2025 05:45:59 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2a01:e0a:36d:2b80:e937:44f0:a96a:94f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1a8528sm4959089f8f.21.2025.11.04.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:45:58 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, "David S. Miller"
 <davem@davemloft.net>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman
 <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Masahiro
 Yamada <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 23/29] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <dee4dc13-b187-42df-93ce-f738cfab32ea@linux.ibm.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-24-vschneid@redhat.com>
 <dee4dc13-b187-42df-93ce-f738cfab32ea@linux.ibm.com>
Date: Tue, 04 Nov 2025 14:45:56 +0100
Message-ID: <xhsmhjz05ud0r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uu7jPrT_zWXJ49jJyMlau8F-pfHeHuQeebrWxodBTv0_1762263961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 03/11/25 14:02, Shrikanth Hegde wrote:
> Hi Valentin.
>
> On 10/10/25 9:08 PM, Valentin Schneider wrote:
>> +++ b/include/linux/context_tracking_work.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CONTEXT_TRACKING_WORK_H
>> +#define _LINUX_CONTEXT_TRACKING_WORK_H
>> +
>> +#include <linux/bitops.h>
>> +
>> +enum {
>> +	CT_WORK_n_OFFSET,
>> +	CT_WORK_MAX_OFFSET
>> +};
>> +
>> +enum ct_work {
>> +	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
>> +	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
>> +};
>> +
>> +#include <asm/context_tracking_work.h>
>> +
>
> It fails to compile on powerpc (likey any arch other than x86)
>

Woops, thanks for testing!

> In file included from ./include/linux/context_tracking_state.h:8,
>                   from ./include/linux/hardirq.h:5,
>                   from ./include/linux/interrupt.h:11,
>                   from ./include/linux/kernel_stat.h:8,
>                   from ./include/linux/cgroup.h:27,
>                   from ./include/linux/memcontrol.h:13,
>                   from ./include/linux/swap.h:9,
>                   from ./include/linux/suspend.h:5,
>                   from arch/powerpc/kernel/asm-offsets.c:21:
> ./include/linux/context_tracking_work.h:17:10: fatal error:
> asm/context_tracking_work.h: No such file or directory
>     17 | #include <asm/context_tracking_work.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> Gating works for compile, but no benefit of the series.
>
> +#ifdef HAVE_CONTEXT_TRACKING_WORK
>   #include <asm/context_tracking_work.h>
> +#endif
>

Huh, looking at this I wonder why I shoved that here. That include belongs
in context_tracking.c itself; I'll fix that.

>
> I have been trying to debug/understand the issue seen with isolcpus= and
> nohz_full=. system is idle, even then it occasionally woken up to do
> some work. So I was interesting if this series can help.

Is there some ongoing thread for this particular issue or is this just
something you're experimenting with?

If you suspect stray IPIs hitting isolated CPUs I'd recommend tracing with
these events enabled:
  ipi_send_cpu
  ipi_send_cpumask

