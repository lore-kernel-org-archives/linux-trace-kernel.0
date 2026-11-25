Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644332;
	b=rt25Ng5qCfbsPFqjtG8mWvS2PE2piYh44Q2rtt8CqQN0q+Xz+lZ0eVMIQWwxMlyt70cp
	 wMFAU/f4fuB6quNUHGSWiBCQgvP6eQlQaHO1bAuOn0AHTeax9y2fvfc4Cdq/6pFveUhKx
	 FszokC55Ccwlc2Rqz2nZBjk2qPkC23T7a1oxib9D73l/s5jfFNxQhbttuxYE5/j0R5n4/
	 70qr4pjK1xoFAGTys2YJqBYOBPG8wUpp3Rs/wFDNOIcsWaPLSCjjTppeOz3+t8ZE3h9h+
	 Yo8CGfD9PKJPpyDGxLl19gyEoqT78ztUOMQmA2pgUE1/f0fOFLKJGLRtJJpmJQRoM3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PFMx5gcHoGq+aybX24krgUmTqr/EIcl1w7rEetCl/eM=;
	b=iYEmv3I7lKj9bk3mLQdg7/EjgRVb7ksCdolbmUBh5atnBPNGzQ71m5Uks85JC3hyb0c8
	 lJuNQqhJ5m2md/AOFGXFhGBpUd/T3j4+kjh+D0WxZsrNh7SDqyglvUaLNlcD7UgYKV3d7
	 yEvzWfcoee956Rak3KUDkeguY89iiVPXiiiue1nQv4mznetLkMsGaKf58SjcGgo5c9Vsd
	 qNQfop4EDPim+sRrQPojOhN2qvx4m4htMiDgxuNSSIdY1LSeB2G41hfMPsBfTou5ybAbY
	 EdZpxkanL1YpwCVB/4kWRS/LkIyngNbEqWn8MLUNGHsN00TifpfRD8h9Pwpz7QO8rtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hRsY6FcO;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1307606A32A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 22:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1307606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hRsY6FcO
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so67956355e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 14:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644330; x=1796249130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PFMx5gcHoGq+aybX24krgUmTqr/EIcl1w7rEetCl/eM=;
        b=hRsY6FcO9VKK/UOP2vT1k2XjTWekQ5+uV5pYD/ykGM2TvFCyGMhb3aYmmesN/XrDM7
         /xa+R5z8TfXWB8q3iC3SJujbwY+KX79yguFoL2/rHEyUduY3s6a2Pv3F0n15bbHIg4V5
         WR2l8gEtzHyz0zdHGDTbTcthKXhlzTX2niHKXed5ySIIvuMR6lYDsV9apaFFC1GKGY0B
         yK6xEfP/kLAM90sSgP4FCwuj10gbhEo45nAoZhvn9+4Uwebuq3G/4Bvae1/F/7yEu/vh
         2FVnxNb/1g8JkQLKE1FsLRvC8Y8DAaiw0iilY6hXNScPUtyZmYfE/0UxFKB10RD4OMv4
         CLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644330; x=1796249130;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFMx5gcHoGq+aybX24krgUmTqr/EIcl1w7rEetCl/eM=;
        b=lU61iwznBQVfgrUU9K0GPYj4hlYocQRg3xddBTo/Y5IiMPLoBidXB8Q+W5T0ZfPtUX
         uJU/D3AUrMp/nsNQ4RSUwnlztH47FgeDUKCN7x81rrXDZqiL1rHJ0+Lab5TXH+BjIFAu
         mJHbspJ5c9r67v45XGpYT/k5As0oRl191OELQH/OQU7UZUqeTsaUkgvdGJC4BxhqjWvi
         HTar3tKqK2HCjecsPyCB/NfREZxwNgGnJibQy57uelMwiCbtoKPY/TQhLsJu5nS2Bffh
         kWwqdE6lQWiBYMSpsa08xqFT/HiFBKFYekDTqPx0+ledQvx4PhmoiDIAJ/LG6ZjXtBw1
         Oe4g==
X-Forwarded-Encrypted: i=1; AL+hErFqs1RBL5be/g7b9pKI2QGqaba69uFmOimpBP17LFXWyMJEmCnhLD2irZuVBvgpkrTK3R7z8kq6cvNE6sv7wQaThWM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vFAkJrslbC0TKSDc77MJtzFxK5riidi9VHH01qWxdmfowwzK4
	mseY+kz4arJEsRCTpbDmfUQ/1U0tg0YMPM6hIl/vnZ8/AOhL4yvjLuFC
X-Gm-Gg: AZFdTZezX4bVW+x8WvvUusj0teER8RN78qet5/1wLbDrp31ld9ybWKNL/Ff/xeufb8b
	iKch55skj2hE0DK9F/U9DDr9oodZdNzeLcD1ffejlO88S/H/8DeWXzIWwlvJ/qAEup2okA4TTSe
	H2QhE+i1xpXbPCO4vJDSseakn4f5E8dVVXvYTxxJJVqgI6y27/xDrf1D5GGbZs6hg6iIT3V6b23
	yUCbfsw6GH6/ttGnz8HWeOPTh1eOiejmQi8KKxHpzr812ax+VvvdmvJx3YO+lmxsh3S0Z5cHwSQ
	bdegXIZ4FN8sVo+7y2lsxIGrt5MXMoW0uW3qJV2Q+fBnOo8Kyu8xWya5X9Jq33wm87iIJkzdwb4
	7KjiHxtiiBdt8LW9tCmyZct37JtFdmvERPRX3bSAfJDCFnk9FR6f6o/oiGZYRCSlz32PLDP+CF0
	ivAK+C0XdSk7rlmXcMgkvYYUJBPTwPeO+cAwsqwVL4IcQMgcJfABl9aDlEWJAgWvcFlrN+zsGuI
	fWV5bi4Orh1iK4o0Rkv5H3MkOMqQvKrwpE12mZkfKsPjcBcWOzgg5iMVDjcEZTUdJtWkAlalzQ2
	+ofqmeVzcpCPTJX2
X-Received: by 2002:a05:600c:e549:10b0:4bb:a60a:fc8 with SMTP id 5b1f17b1804b1-4bba60a11d2mr42321925e9.35.1795644330050;
        Wed, 25 Nov 2026 14:05:30 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm1016582145e9.4.2026.11.25.14.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:05:29 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Nov 2026 23:05:27 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kprobes: Increase the kprobe hash table size
Message-ID: <awdbpwBAyzIdG9tL@krava>
References: <20261122200239.1481088-1-jolsa@kernel.org>
 <20261122200239.1481088-2-jolsa@kernel.org>
 <undine-1795477745290490698-99e2fcc5c9b45beb@undined.local>
 <awWdDfj1fknA8fuF@krava>
 <undine-1795616480318619368-1be7e961905611b5@undined.local>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <undine-1795616480318619368-1be7e961905611b5@undined.local>

On Wed, Nov 25, 2026 at 11:21:20PM +0900, Masami Hiramatsu (Google) wrote:

SNIP

> > > If this change is intended solely to improve performance for an extremely
> > > unlikely use case, I would, at the very least, make the size configurable
> > > via Kconfig.
> > > 
> > > Since this change affects all architectures, those working with small,
> > > embedded-system chips might be reluctant to "pay" 32 KB for a use case
> > > that is highly unlikely to ever occur.
> > 
> > I can add CONFIG_KPROBE_HASH_BITS with range 6-16. I'd keep 6 for
> > CONFIG_BASE_SMALL, so small systems don't pay anything, and use
> > 10 (8KB on 64-bit) as the default otherwise, which gets most of the
> > speedup from the table in the changelog
> 
> That is good. If you introduce the inline function support which is
> enabled by some kconfig, that kconfig can increase the hash bits. That
> should be more reasonable.

yes, good idea, something like below, I'll send that as part of the
inline tracing changes

thanks,
jirka


---
diff --git a/arch/Kconfig b/arch/Kconfig
index 1163736de1f9..350144df6863 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -141,6 +141,23 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+config KPROBE_HASH_BITS
+	int "Kprobe hash table size in bits" if EXPERT
+	depends on KPROBES
+	range 6 16
+	default 10 if DEBUG_INFO_BTF_INLINE
+	default 6
+	help
+	  Size of the kprobe hash table as a power of two. The default
+	  of 6 (64 buckets) is enough for a small number of probes.
+
+	  Attaching to inlined functions can register thousands of
+	  kprobes at once, so the default is raised to 10 (1024 buckets,
+	  8KB on 64-bit) when the inline site information is available
+	  (DEBUG_INFO_BTF_INLINE).
+
+	  If in doubt, keep the default.
+
 config JUMP_LABEL
 	bool "Optimize very unlikely/likely branches"
 	depends on HAVE_ARCH_JUMP_LABEL
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f14f7ff45961..eba446e8ae37 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -50,7 +50,7 @@
 #include <asm/errno.h>
 #include <linux/uaccess.h>
 
-#define KPROBE_HASH_BITS 6
+#define KPROBE_HASH_BITS CONFIG_KPROBE_HASH_BITS
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
 
 #if !defined(CONFIG_OPTPROBES) || !defined(CONFIG_SYSCTL)
