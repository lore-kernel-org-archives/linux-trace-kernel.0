Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85030223324
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719945; cv=none; b=GVAfbs8sOikFkAc26DMUHG8eHqOY2tlsk+AsRggNe+1eoJsXskhAjPcl1Y6uRAzNmRPiOEByn6lKt8LNZ3Mwq29/Mp2crXy1lOoPO3mCGk6wr2ea6Pz7DR01ebpZxUGgLpm4Qg2jsReafU0c9tXe3ml7xEDg6b82dbuQmduYBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719945; c=relaxed/simple;
	bh=nIxOA6aOVr6gGSQiExzc8nNHFfpPye0obYzpAtlDgI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdSpq4rTmx7hV92Hbi5OENhWyvaa9cLMEeNWlB2cgqWcBdHGtuYQtSxAOPjuMSV0nKc6NRwj6QNRu73fdYBQCG513ZYd+p3H4BukPAsozFpLtzDI0UTsPgzH5IYMSUFePIqHUkD2vUZhCEavou9FGdMfWrB+LvkBNemYVtAFfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOK+FY87; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOK+FY87"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763719942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZIk/6eiWFE7r0Pz8jIgtNeqgPIl4m+Z/Z67QWlEwbg=;
	b=YOK+FY879Am7GnPXbNLmSgDD9+CwCE35ZTP111/C75w6L6OtMB75MILjDrXLsK9Yl7VOqd
	9vkqDFih2SuH6BKKfbDoa82R2hHE2K5NtORIUpXT2hp6wqOPmxxN81vmwMRCetrS29N8wq
	zHDfF3e3Mwkpx7biyfMKytTcPvPA2fs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-vII5Pv8HNi2WpIqJ4GlAFg-1; Fri, 21 Nov 2025 05:12:20 -0500
X-MC-Unique: vII5Pv8HNi2WpIqJ4GlAFg-1
X-Mimecast-MFC-AGG-ID: vII5Pv8HNi2WpIqJ4GlAFg_1763719940
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso1624736f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 02:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719939; x=1764324739;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZIk/6eiWFE7r0Pz8jIgtNeqgPIl4m+Z/Z67QWlEwbg=;
        b=oFVIX6Tsz8KP+xdH8+V7rj+TOc+rCp5aWncB7dEKf/Uw6MrgPxIXttMRbh/VxgNGkj
         zQHf2lRF7afEiwOOaHSda4GtzyeQiIthDv1YJn+u1EdfmSKUc7Hs7Hc/JY3FMkioOghe
         HnjxBtE3TwaTeMsXFzfD+UYCz0AaZsgGiVwlrK711gnucM7E/pdDBCz+Omz0ccie7Ato
         tuktxfaf9dGtBqTZ0EL/0ZxgRO4/xSars7IvPdWRvFxEe49dKf2lb/41A5t/msfBEkrl
         fNdkorCAQucJ0x+zgZkxe24khxXPNeqQzCqtopopeIx+ttDJwSpK3PZGhwSTdKQdQ4J7
         UE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWxRbzrQEf7P3U7FOkHOvZU9OOvcr0QU62GHJdCoJhagUhwpPYM7J1dwyTfByxM1daqEcFzzAvel6Tm/M+2YEA+Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/d3gStK3FBPMynBMBbFt9N7zvAAEO0bYtVqumPAuXXo8z8bK
	Guh8uJDgBddFhX9fxqo2XRpL/xJ45WqeXPur8QRfU/0UtDXRUkz2BxXO+uxwhI69ifdAVkg60Lc
	9uZJiYuQic2v75YvDGTfRWA1/L5t4bbb/00K6UKaDWpVPI1InYnodK4DOI+0GBsHSE6EVgmm8Gw
	==
X-Gm-Gg: ASbGncsIcB0LDyzrJf0HKq9OtjNgbu3ClLYFNUHgsP2wv/MxCLg20/kNmchgTYyPdWs
	nf0JedTAFup/JjZk5vk8CqCRjMXUAN0Iv89cBjSLB0oOibjlpV5UT0E05vg3VHZfXJp887NOrrg
	uXPMcugiHiulb4Kt1NuzgJ7X93RGIrD1uT2TmmEDTP3/RJ6CInoWSTzEnBtb4MtQ41RTKef2axx
	KmQd2OGBI8D4PvZ1+plXjTEitEzVMPjQWvaYZ3mAo2rvc8zLMz2MzfhquCGbiyAuULuXp01g5xH
	akygTUH0mMsxNutYThuVgy/qnfpGwPF7PXOX66HZmLhxq15ImT3Qd2xAUZMM7b3aPD3H/HDfyT/
	C/Zwl+zmMKK+xAIRR3cE/3JtBs/+dxzpKxYhIq1SgHeYBjw3dEzSBmjV+FtE9P8VgEBl6AEM=
X-Received: by 2002:a05:6000:1888:b0:42b:3ace:63c6 with SMTP id ffacd0b85a97d-42cc1cbcdfcmr1795916f8f.16.1763719939500;
        Fri, 21 Nov 2025 02:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQwvNnN1+6xkIr+bJK+olrvC0Z5OYdiF1L0OBTcrYbQMUdl7o+C2/hye3fKlSOf/cE5aQ8Qw==
X-Received: by 2002:a05:6000:1888:b0:42b:3ace:63c6 with SMTP id ffacd0b85a97d-42cc1cbcdfcmr1795834f8f.16.1763719938945;
        Fri, 21 Nov 2025 02:12:18 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e432sm9799426f8f.9.2025.11.21.02.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:12:18 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, rcu@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
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
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [RFC PATCH v7 29/31] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <91702ceb-afba-450e-819b-52d482d7bd11@app.fastmail.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-9-vschneid@redhat.com>
 <65ae9404-5d7d-42a3-969e-7e2ceb56c433@app.fastmail.com>
 <xhsmhecpukowa.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <91702ceb-afba-450e-819b-52d482d7bd11@app.fastmail.com>
Date: Fri, 21 Nov 2025 11:12:16 +0100
Message-ID: <xhsmh8qfzu22n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5fZlxxt5kjRRiaZtU2zuPwfUTOUHr3bk91KueWHRBBg_1763719940
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 19/11/25 09:31, Andy Lutomirski wrote:
> Let's consider what we're worried about:
>
> 1. Architectural access to a kernel virtual address that has been unmapped, in asm or early C.  If it hasn't been remapped, then we oops anyway.  If it has, then that means we're accessing a pointer where either the pointer has changed or the pointee has been remapped while we're in user mode, and that's a very strange thing to do for anything that the asm points to or that early C points to, unless RCU is involved.  But RCU is already disallowed in the entry paths that might be in extended quiescent states, so I think this is mostly a nonissue.
>
> 2. Non-speculative access via GDT access, etc.  We can't control this at all, but we're not avoid to move the GDT, IDT, LDT etc of a running task while that task is in user mode.  We do move the LDT, but that's quite thoroughly synchronized via IPI.  (Should probably be double checked.  I wrote that code, but that doesn't mean I remember it exactly.)
>
> 3. Speculative TLB fills.  We can't control this at all.  We have had actual machine checks, on AMD IIRC, due to messing this up.  This is why we can't defer a flush after freeing a page table.
>
> 4. Speculative or other nonarchitectural loads.  One would hope that these are not dangerous.  For example, an early version of TDX would machine check if we did a speculative load from TDX memory, but that was fixed.  I don't see why this would be materially different between actual userspace execution (without LASS, anyway), kernel asm, and kernel C.
>
> 5. Writes to page table dirty bits.  I don't think we use these.
>
> In any case, the current implementation in your series is really, really,
> utterly horrifically slow.

Quite so :-)

> It's probably fine for a task that genuinely sits in usermode forever,
> but I don't think it's likely to be something that we'd be willing to
> enable for normal kernels and normal tasks.  And it would be really nice
> for the don't-interrupt-user-code still to move toward being always
> available rather than further from it.
>

Well following Frederic's suggestion of using the "is NOHZ_FULL actually in
use" static key in the ASM bits, none of the ugly bits get involved unless
you do have 'nohz_full=' on the cmdline - not perfect, but it's something.

RHEL kernels ship with NO_HZ_FULL=y [1], so we do care about that not impacting
performance too much if it's just compiled-in and not actually used.

[1]: https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/blob/main/redhat/configs/common/generic/CONFIG_NO_HZ_FULL
>
> I admit that I'm kind of with dhansen: Zen 3+ can use INVLPGB and doesn't
> need any of this.  Some Intel CPUs support RAR and will eventually be
> able to use RAR, possibly even for sync_core().

Yeah that INVLPGB thing looks really nice, and AFAICT arm64 is similarly
covered with TLBI VMALLE1IS.

My goal here is to poke around and find out what's the minimal amount of
ugly we can get away with to suppress those IPIs on existing fleets, but
there's still too much ugly :/

