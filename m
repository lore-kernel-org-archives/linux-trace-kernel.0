Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939819;
	b=pK0CGFK79+zJPs+OhWPkV3jFzcF/ZF38MqhehMDFjaJpU7NX7SdPd3K6ntGZ+OFIvItm
	 XqSlIZsFezsrby8qteQpKIc1WXwoyF7Bq0Hwv9u5tTRz9ps/Lkh76aJewLT2QLuxD5h49
	 +vsEZIUTOuNfjZ2MxvjDNsROceREnaL2x/fDoN1nNZfGeZ66e+eGl9OrDbnlrk5776k/r
	 i/ooGRgczgR2BWoLBbx8HI3pgLe4z0GjY2fx7uW+mU+V31l3kVxQOhKR8kXx08/A25yA+
	 Uu172rX1T8XXNw2AqbyW+9FeqNTq6cAHMmhUwvdVrkWs3rLiZCXHNUvbDvQsrM6TfIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HzWKenQn9WhmPU6V5OUgtiFs+SCuy+G/69gWaeerzA8=;
	b=boPcfaQxbMzmuwZSqJsHrCLBdxT6LWIBQWOqjhOXDqBX4cymJugiXoCeQH9G3+cUHdUU
	 +/ytBGVAd1Rf4QDCZQ89OdNwdNV1ptgKm9zbVSHb0bY4n0gT6ZA5AHGpRC0ng6lcM+v/S
	 lC4m7QiygpyilIw5UbN16AL8XQPPBus1+D2j0gqq1lI+z4+dofLdPYWEF2REZdFPfxDHA
	 40YFbUpKicdxlvfR2pF1z2/hwDD/8x6XjkS2y2BYhMBU8QUFt0b+uwTfVS1/JUNDNjLZn
	 rTVRu6t2y6AJQuk7WVlc21XEkLoVRMOJuMjRZkScrs0BciB9IY857SfXPFHtxGLeNSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Fs0t7aMq;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F159606A31C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 18:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F159606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Fs0t7aMq
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-381d542bc29so339442eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794939817; x=1795544617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HzWKenQn9WhmPU6V5OUgtiFs+SCuy+G/69gWaeerzA8=;
        b=Fs0t7aMq45OPSpgcIz2hTrysWX9armSQaVfgNFDKxv6luHnyDd/lJuU+nHc82+ZpHW
         SRuYKWDQ2/VjtxvRpCvJ5oQAbfs2vjgwT+x3VsLnkoOp0r0q8ytl6w4EEjQYFlTD8HSI
         FrGQnZPYn/+U7vV8Tp34A6bqeCWqb1ZyoIYFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794939817; x=1795544617;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzWKenQn9WhmPU6V5OUgtiFs+SCuy+G/69gWaeerzA8=;
        b=bKxv1PJ0xQSYbaUcgP4Zg4G0AvuiqG/zxXFDEqzCUOBNpi/wigf91exqFZlGpVwKRr
         ocZNr0fXVi1PS9YwzEfEJbPed9H89Smmu350eTQjg1X7bOo/eVmm1VYsz5aA/yU+dqCx
         h2zUn6dP3RQnSUNiebFhfXbMB01T92purBH7cNc869LxpGDmhSKcP7NOQWAUg4aqO5I0
         Z3ax+4DwEIBsge4kNAUNwIIRu0gUf8ZKSFBb6KwyL/0No+eRgJmjmS44raM3ODMeLXid
         PNgGoXbiVQ5l0gjgEhS9eG5HoTlqKVrmIn+LfF+4AKb0uxfMDGHO0gH8K6/ZbMiPK5Xl
         JKPg==
X-Forwarded-Encrypted: i=1; AL+hErGcdcpzCyaAnNoMkscfN8jFKSoEtwC0Tshe+VeCaUrGHJxNFpEu9ZCDI3zRW6CQjvz+I1tKg+EaP/UhRzuh1hMmU2c=@vger.kernel.org
X-Gm-Message-State: APuU4Z//gMCEkZ2qZnTroOi+M4/qA1Jwpa40YdkGVEpF/J+wKHZHVoBC
	MBVb32vZNGgc2uZ/jnKPnt/UiqMY82zbQPv5as/tCG+5ZOsuoj0Ex2V/fMuDW4Xj8Q==
X-Gm-Gg: AZFdTZfTZNRZ0LT9GIu9kq4OmaSu0aIRpg4nKoS/JVBbF2Okx4YYw+nWTd2haKgAMEt
	RhKka7Bqcl4kNRXk3A//+MUgJzOoJzeaTiK6jhsPs6fTjUQhXcgDCd76RuZJZAB4H2CYWDXrnJo
	4T4E7fhdpqUlX1Efxc2WR/jdB4BKXJIrPqNuPFSA8PsqKC53JV3uSH79GeaOfmJLrE3qGgwR7zQ
	Xl+Amo4eOmvJevdnj/ZMwYbN7GsWDQi3+wmdUK4x1sttS5seV96VQsWywNk879njS9O0w+YaVZ1
	rJbVwpu6nkQZQZbC+m6CXGruulp4L7misoij4Ss7k0Q4aBDlp9RkrDiwT5XIYK0Sd4EmzI127vE
	mxxqiTi0npKmDSLzzba0DyrjNKVWNOlBIaYVVPt1EyWzwnXxrHy/rsr3QxQP3AfSXsubJL/Kjx6
	YhSrJvFIytygfgENxYCFecjPQdhI6LefY0KSa5BmEnX4xIlOOdSIxm98g2ofGY1Dl1sTtGJHt7l
	knnfsepv3XEwDQarjOuMDxu1O62Ch/R5TFXfVumYQGimOwQcIiwokag4+MPldGb8Q0X3nQecynX
	22rARjuBBQ6nzqM7rowS2XKoYsy5n8NA40o0VQxkPvnc7dNOAwxOqhgWNAZhYo8m40oS
X-Received: by 2002:a05:7300:d186:b0:36d:9900:bb92 with SMTP id 5a478bee46e88-3827fe78136mr207819eec.10.1794939817500;
        Tue, 17 Nov 2026 10:23:37 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d92d:531b:8d97:bf51])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3795378c2fesm45544467eec.1.2026.11.17.10.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 10:23:36 -0800 (PST)
Date: Tue, 17 Nov 2026 10:23:35 -0800
From: Brian Norris <briannorris@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Message-ID: <avybp3O2zxcLozKB@google.com>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
 <sashiko-outbox-217828@kernel.org>
 <20261117085552.0e4ef272@gandalf.local.home>
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
In-Reply-To: <20261117085552.0e4ef272@gandalf.local.home>

On Tue, Nov 17, 2026 at 08:55:52AM -0500, Steven Rostedt wrote:
> On Mon, 16 Nov 2026 22:58:01 +0000
> sashiko-bot@kernel.org wrote:
> 
> > [Severity: Low]
> > Should FTRACE_STARTUP_TEST depend on TRACING (or select TRACING) instead
> > of selecting GENERIC_TRACER?
> > 
> > GENERIC_TRACER is meant only for full tracer options so that
> > ENABLE_DEFAULT_TRACERS is hidden when a full tracer is enabled:
> > 
> > kernel/trace/Kconfig:
> >     # All tracer options should select GENERIC_TRACER. For those options that are
> >     # enabled by all tracers (context switch and event tracer) they select TRACING.
> >     ...
> >     config ENABLE_DEFAULT_TRACERS
> >     	bool "Trace process context switches and events"
> >     	depends on !GENERIC_TRACER
> >     	select TRACING
> > 
> > Because FTRACE_STARTUP_TEST is a test option rather than a tracer, having
> > it select GENERIC_TRACER disables and hides ENABLE_DEFAULT_TRACERS when no
> > full tracer is configured, and implicitly pulls in TRACING even when all
> > tracers are disabled.
> 
> Actually, the selftests should depend on TRACING and not GENERIC_TRACER. It
> may have been that the self tests were added before the trace events.
> 
> But it should not "select" a config. The selftest are only to be selected
> if there is something to test.

OK, I can respin with 'depends on TRACING'.

However, I think the Kconfig setup for kernel/trace/ is still a bit
haphazard. For example, it's reasonably common to want EVENT_TRACING but
not the more invasive tracing (like FUNCTION_TRACER; and therefore no
GENERIC_TRACER) -- this is how all Android kernels are built, for one.

But there's no user-configurable way to enable EVENT_TRACING. We only
get it implicitly if something else inadvertently selects 'FTRACE'
(which selects EVENT_TRACING). For Android, that's CONFIG_KPROBES and
CONFIG_HIST_TRIGGERS.

...or is that what ENABLE_DEFAULT_TRACERS is? Its name doesn't really
suggest that, and it's mutually exclusive witih many other tracers, so
it's a bit awkward making choices, as the whole system appears much less
orthogonal than expected.

Anyway, my point is that it's not exactly straightforward to enable the
features you want and get the tests you want.

I've appended a diff that seems a bit more user-friendly to me. It
makes it more explicit in the menu how event-tracing is forced-on by
many other tracers, but is user-configurable when it's not forced. I can
formally submit it (in 2 patches) if you'd like.

Brian

--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -198,6 +198,7 @@ config TRACING
 config GENERIC_TRACER
 	bool
 	select TRACING
+	select ENABLE_DEFAULT_TRACERS
 
 #
 # Minimum requirements an architecture has to meet for us to
@@ -595,7 +596,6 @@ config MMIOTRACE
 
 config ENABLE_DEFAULT_TRACERS
 	bool "Trace process context switches and events"
-	depends on !GENERIC_TRACER
 	select TRACING
 	help
 	  This tracer hooks to various trace points in the kernel,
@@ -1135,7 +1135,7 @@ config FTRACE_SELFTEST
 
 config FTRACE_STARTUP_TEST
 	bool "Perform a startup test on ftrace"
-	depends on GENERIC_TRACER
+	depends on TRACING
 	select FTRACE_SELFTEST
 	help
 	  This option performs a series of startup tests on ftrace. On bootup
