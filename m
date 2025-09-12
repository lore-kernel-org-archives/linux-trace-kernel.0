Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E312270EA5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757656311; cv=none; b=hR6kNsaUPJpw6MXMvn0nd12ZPXT9D7xkfueyAAFHHBIM/nURRMG1U8nxIurTFfvDJu+9MH0c6dxWyhlMnfq4uKmp1OQsrFmUjADBYsRyTjkt4lnmg8boPOjwvO95srKxmIVmZcHLegDWEiHfaE1tyfBxizqNrVeW3GtZni9afpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757656311; c=relaxed/simple;
	bh=7i6b0HQZmpItcoHiRjDWPxsI+KEN2RjAWI+wYkI2Gzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND9OpVrdjGrS+KK7mqtAb3q9hLkS9/7BBeWQRG5DuVkHAdCLRpzytqEbyjIx0z4kh8IXTlI/tm/UiFwS9rosLg2U5RXo+/brw6fjAQeClNcquRRsQiIExbrljF+B2Sr+fZ4+19s6bn8L+vO+I9BtR87NyYyiiKuf0Nv6zMDMizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hooFbfX9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hooFbfX9"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1506820b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757656309; x=1758261109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwxrf7orhL2KYO0iCZZdsGPUWyavjuMuxgjcqzj0tsA=;
        b=hooFbfX9qGIPRouDdpxKBh+VC5sYTXZliz4PmWvxPCKl127AIagsLLtwPvzPQBXWHP
         s4ekyjZzE1pcGPnQ0s5HDN/8EHEH4Vm4cCTG6oPTDCBSuu2ZdF16Zq2IqYg2/iKHJ7nI
         4IwiiHRCcKEiujfc8bI18/8dED7qymMVGHMAHCFHcO5V3hIyrrE+dU/BGvOHbNYJsGHa
         WfHh4XrwKEWttPfNv5Nw9NE7cfEfvp/vXkwGzC/TdDX7emiY5122jLuF9EdigCoNkO8Y
         4Su5s+5Rl6OMi23xBHWUrE9UiE4W5DSA4YCBfNaQR1X0D04uRrqtGVobhP4cr32bOK4Z
         lNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757656309; x=1758261109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwxrf7orhL2KYO0iCZZdsGPUWyavjuMuxgjcqzj0tsA=;
        b=I1YYWXM9ORQxagcRKhxXu1UGKBTtGPyVlEmzgRvZqJmGZVk63gUbz++wwy0VNpPg6E
         mZxLcRpta9dVAvhBt49kVwKwJ3eq6lo0RiuilJr7ftjxbVXDqS8sU4FzbunWB71fN8vq
         NkFOY4JQVSLjPCCdorF48NBEvRyhXZdSe01ZjxvQxLoAay6B++EyJbEHnlMM6bWb4eUW
         PJDUNJ/M1beTiaIjQ0Qc7/dqvbyyDW5NjjKO9VG0Ks5q1Xesi9a5twi/AQ8mLkeXbAbd
         8mVujIvK/II0tKHBgggXKYQMZfKrP0tLClNSpZPGcTzx6FLg1J8Ymv97dAFxj4on7Q61
         n2ag==
X-Forwarded-Encrypted: i=1; AJvYcCUUNR4Pdu1MwJdMSAnvUCUCVwyELNCzzi2KDTA/kAki8UZHdFnnv5cAKJy8I8Pd1dNZKE9ZSincaAi2KURrFkWYrXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjSFzeFtL8uOeeK1I5Hgr+JyZQvsmZ6b4MOtYeqraclcGFyP4
	npaKkSpJzEv0e3DFLC0o7LN0pP5dRyn3bvbxaWeqmDElV5PxeneVA60g
X-Gm-Gg: ASbGncuJfI9GD21cDtxX0T1vW7ZwJQR+fWrLECMGk6rZBi7heZxXNSpou4aiaxpc7kl
	IxdxxaxBGCuA+8eLlvZ5Mhhtmg8l46rX528uCUr3rF+15LWrnCleijkh1SJdXDl9I0bRay4oFUw
	D+T9mSm0V+qf+vclmTkRhebflGgRe0an2Pwadfr1UpEAzfXVajKHoI6otEJbj1Tqda79xMHT1oQ
	kto6p2TACR/z14hSlllczYsCUQ8Bpeg0NJ1B7BXXfrlQRtgxZQKKQq04f5bYBwALINhPLoLMySO
	TDmzqQE3uRUhHqJ+TOj7J6Xp4jBdvpgIxy0gijLxQglgZ5b3xxmuqKDaC8Pzf4Xexs9wGcWr2nl
	9z9b6pRatP9XkGE6+JvxJAkW2oWlH6DsuWoWgQopQfsKgrA==
X-Google-Smtp-Source: AGHT+IGzJaB63wIa8y1WxrhARLk2qyeDzg2l8cffF9pjyL26hVSSSTlaS01B7UHtSYXcq7zGWNVPeg==
X-Received: by 2002:a05:6a20:7f9c:b0:249:467e:ba68 with SMTP id adf61e73a8af0-2602c90cda4mr2342631637.50.1757656309414;
        Thu, 11 Sep 2025 22:51:49 -0700 (PDT)
Received: from localhost ([45.90.208.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761853866bsm450111b3a.95.2025.09.11.22.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:51:48 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:51:43 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/19] mm/ksw: Introduce real-time Kernel Stack Watch
 debugging tool
Message-ID: <aMO07xMDpDdDc1zm@mdev>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910052335.1151048-1-wangjinchao600@gmail.com>

FYI: The current patchset contains lockdep issues due to the kprobe handler
running in NMI context. Please do not spend time reviewing this version.
Thanks.
-- 
Jinchao
