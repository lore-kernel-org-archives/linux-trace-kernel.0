Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2FB32C952
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604735; cv=none; b=WI0QErIFX6KJUWdgmHN7Nr2hXQe20GBbJZgh6y6V262tnT3LNOtlOybssWLWJTrLc+D8BODIA97DfC+PGOCFnLhnWDrVFjfjvUGYTLkPISqOOXuzqgLUax/oUII392pGerrqz6Qwh8q20bQhl0RUF9huIfpLTrqMPjhSvWyaURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604735; c=relaxed/simple;
	bh=mZopSRQVUi4354yRGOImkW196b7/LGd3/FDZsbsQQ0Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCZ+p1HA05zjyPW0faAlHqiL4eK5oPamwZlSnYTSFPtEWOhbYenr/6sfFgBc0dbx1H4QWx2i81ewZvNjbmgQead/+oi3U4V1orRikYwh8vU80oZHdoBZpX9kUYqI06ZqM15UpQMoqebXZzeyq4PrnQKwdXL1MNK4e3bT3uyWT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPIKQ7c+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPIKQ7c+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710683a644so43643315e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604732; x=1762209532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2tPDXG/coalmGQ6BNmejw+0knfQZmINzdFwuhoTotE=;
        b=WPIKQ7c+jry89ufIboEqbw6Vo9Xeq7CWNXYgGt9w4eSAvN2dvOeZJYLSlKvqv/Np8B
         QifYKJMBE4BpkWqyf3bxE6RUHGXNPFjfp5LT3kYmmZYo6WBCe0220x8Czf0991re3SCo
         gOADUa9r3CJ5VYcf8VvA/NsxZ5Iz0kq+6+8E6ZN5sK8Es/0X0xSLGy/tiMYucOZ10pt6
         M1KPLUP0lzFUtX28FQQopZCKNwUvenPBDwQf3l/MII+YZT4Cxfw+FiLofOe5a2snhCW8
         WjYfw2K9nWQPLFcG//MxoF0+sNeyGC5zH3ROhwaKU9kz8ZwEaRVrtYHT/XmXk5zcOffe
         JD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604732; x=1762209532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2tPDXG/coalmGQ6BNmejw+0knfQZmINzdFwuhoTotE=;
        b=LSSXiNIdb/YJWJrwLP0qWlzOxFKTe3f/eHYLgRld+zFyiS/CDE/LLldoLLdObNc39w
         dy9g7bS2/PPffReyO2mWmrRpRe4JtDHHygWoAe1H596Hv01PD/PS21Ar61pbTlQx1Pan
         cBNV7AmKAknPhdr9yku6pnMPGa+cBwdRL3jUkHpVUj7nyAUkrYmbpdFeiKS9KgmMhgSx
         VrrXVEzOJs8TEKpmXJDgK445qD7pTHpPV560sQr2XaEmX2Y+8s28QgkM89M+zgX6IAm3
         +C8D/X4nIMbmAOk9RpxjkOlbDo319F61l3Pn5Wyi4Oi8tytFGl4EhG78Got+5yewMTd0
         avyA==
X-Forwarded-Encrypted: i=1; AJvYcCUdHmGIuGfByrWNwZgXuVFk/lT6is+WZYsWAp2pCvn6gA6eOz3ffQRvW6sJHKZJbv7PQK3dF9n/jD1GIJCaOU9fBLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZQQGdJ6K11f3lz2Vb/fAAbGU3NS4K86eLdkJEXv8Z8E/CTAb
	hwb4M/mTOJwXDTrwk+zTvJE1oQq12OFPzKxWetLj8HYC5c0p+p+UAcDS
X-Gm-Gg: ASbGncvinew5TtaE18nq0G3ZVjpyn7F0p3puKgV/RBUirUnn5hRmEJFPij9VIb5UL7f
	kGGNseqInjeAD5u9ZR9YA+qBh3zTwgaFK02X1mkYpLtNobzg8nty9UPUZWHaWutxFf8D8Ly76y4
	lE0/IUhai0OPhWx6AUOxnzijbkfg3cTCPKDvE0a99N6c9cZOve/wX163C91ReDbosXOt1VRp4gp
	6rlU8Q1IRt7HjYyo0sBflq1hCuMeU3ZNOKKVAYBkvvhh4pEQITGesbWRFM5dwiM0unEfgbDmjB6
	Cy4ihk5Rr72IVz35sUnbS5eT2QV0QQvqgYg5mPN0pz019KzOGOmn0NAoMd5jFAdgBn4wK8O1wDr
	lnz8jwD/4KCuGKCP9dFIeOvLh0gMPPqTDPEr0rII+l03jKxxtxSP0oMwhj0UrOQ+TezEuCTZz+h
	o=
X-Google-Smtp-Source: AGHT+IFiCCMIf/Ghw+gRyN8J8phGReAHAwec4nlXGAJ5oIjeHM5dgNEnOqJddAzoxLYreIXmbyyrAg==
X-Received: by 2002:a05:600c:4383:b0:471:793:e795 with SMTP id 5b1f17b1804b1-47718051848mr5826915e9.0.1761604732269;
        Mon, 27 Oct 2025 15:38:52 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718fc0335sm4081905e9.2.2025.10.27.15.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:38:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 Oct 2025 23:38:50 +0100
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bot+bpf-ci@kernel.org, mhiramat@kernel.org, rostedt@goodmis.org,
	song@kernel.org, peterz@infradead.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
	songliubraving@fb.com, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <aP_0eh7TH2f_ykhz@krava>
References: <20251027131354.1984006-2-jolsa@kernel.org>
 <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
 <v53j2leswscyunqmrj5zvr3bsdafxlze5z3yp4hvsd6epbvdvm@njx4yhpkqoiz>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v53j2leswscyunqmrj5zvr3bsdafxlze5z3yp4hvsd6epbvdvm@njx4yhpkqoiz>

On Mon, Oct 27, 2025 at 01:19:52PM -0700, Josh Poimboeuf wrote:
> On Mon, Oct 27, 2025 at 01:52:18PM +0000, bot+bpf-ci@kernel.org wrote:
> > Does this revert re-introduce the BPF selftest failure that was fixed in
> > 2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> > still exists in the kernel tree.
> 
> I have the same question.  And note there may be subtle differences
> between the frame pointer and ORC unwinders.  The testcase would need to
> pass for both.

as I wrote in the other email that test does not check ips directly,
it just compare stacks taken from bpf_get_stackid and bpf_get_stack
helpers.. so it passes for both orc and frame pointer unwinder

thanks,
jirka
