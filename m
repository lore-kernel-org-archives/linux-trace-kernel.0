Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987D21C9F8
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Feb 2025 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738711455; cv=none; b=t3KF5GXxr6WdHkLq1ax02ss3hKPT+I/qoxkFu24XYg2lid3FhgWjbdAlhwvUBF68za/xBXbYRaY5gTODUvo8ToyhJOcTCDePzlU2gX5D6TKqNKxl6+0NB6WA8yNY4GlzzUeZiW+PTpDLYAD420UtQvGza1/nfR/wctgDXPQRc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738711455; c=relaxed/simple;
	bh=FEX3Vdh+NEZiYfGk1vrrsJOKApKBG+9+aixlZ2R/lW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTwqoPMs63pvN49EXohX3DHWJwSpNtiyKGcWJZHsRN+9VwWejQrO97Z8KL2+UPWN6fLLyttj14O5dcN1Ybi4oRqDAPs0qhustAxX/7zxlAgguyHUglXarr2CzuNpolqpWT5GTUq7DZPxhzI/JK8tFxM15MnwvwPSE4M8idxhl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NIwPyW0u; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NIwPyW0u"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844e394395aso155139639f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Feb 2025 15:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738711452; x=1739316252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7C+mmXcghpctUltjMuPzZT5k+4ILd9aRvVJeIVZ5h7E=;
        b=NIwPyW0uky7MWvSUA4RrnNlmxM/EWqPpshZxttoVAADQYvbO1fKez3zdMlkX9PhkYD
         CTJ8uVIWJxJ7+3H6gmYO3lswgiCiktGMZ31AZ0dCBy8zyObMc+zb3FXBBwQbIohuwmiL
         sg9ATWw4dbquEfcQAv0dx5LlPTt4m8GYEs4fG5mSnf+ynjo02KyG7nTZ+AXtGiivWaBd
         oQBK7ibjWxaj2ZzmUHVPErbOsg6sf6bG6779s7hUnqak1ifazJqK1x/UL2OI+JmeTKVB
         J5uopAn9P4bGV+hWWrhFwJb6Lgrt/41Id2uoxvy85xEUG/21O0yfSwA6MENKOLf1iLRy
         BMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738711452; x=1739316252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7C+mmXcghpctUltjMuPzZT5k+4ILd9aRvVJeIVZ5h7E=;
        b=pmbKXb8/KC9LAKB7KH/5J9ckgAlxPi6E9ItA9iY1Ek3pSzQqLwQyx0f4P0uvoSCRFz
         PgKoj3ObtJay2qsGuKRNY6MjM/JzJGRElGf2r/XmihTBH5msfVMcPAAo/eYPgwz2IjSj
         u/fhqAfjXYgIBq9T7BrIS34/Ce/XYsvC5dzMrtuzyooLZ58WHNjTNHrSm/Tslb7n5gBA
         JeW1g+Vbjqu8PmWbcax63sdo3t389g9Cs+zb1EP6XcqLelyn+baP+s9Xc306jU6KXTAv
         JlPW9gPB68PBuERlQnKmLJ7687cGXDTvcCZwVD2Uqq7C2N83eHxjdsb3S1k4pohX0VvC
         uNRA==
X-Forwarded-Encrypted: i=1; AJvYcCUzdIe1wjvsGbzvFIfoIL017X5XqXrlY/Rf/FJN01CLqF+HEyywYWVmMBmSc3Qpbd1Wt1TATQGGyYzIEqhgWHaIBk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLfL0M0XpDgc6r0k3t0lBHOzbyRCb1dUSkC8IveneiZ2huRaoS
	HKpX5vY1+/3VdXwYm7I/EiTJMqRLkQjvNexki/Zlbdrv7gBdFWDdoSYbkdVZ6EY=
X-Gm-Gg: ASbGnct27R3a4FzkpWdFAuGaFNUkznjnqtgtgxaYiGmAe0feVY4hWf8jucZXfY5AJ+m
	kENy0ss7L0j4szBwQhdyLObA+JVIQFFgZThTUnoIyBksb9J/LSESBs2qP6lH6H5mAjGu1KsP3l6
	ekkxcADH7uf3zwTJhI66CizI8gd1fhrwslgSAxadwIoNJfPqstjlmVlfHmUW64C+aQIk8KB7wtt
	YuZxz2iaPCrhet4TZmzevOI1Y3Ya+HZVu/IBYCTlZHWzrNoXW5ej1bqzEh3UEAdOCSzYnSQwm98
	CqD9Hw==
X-Google-Smtp-Source: AGHT+IFk01l67w5flnt7AW1w/8rmtq99wc4nbdFvSpX2xfx/D9I29fUoitlQP4S1XPO0eaV5SdxmsA==
X-Received: by 2002:a05:6602:3711:b0:83a:a305:d9ee with SMTP id ca18e2360f4ac-854ea515978mr94544239f.12.1738711451927;
        Tue, 04 Feb 2025 15:24:11 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec7458ed1bsm2990762173.4.2025.02.04.15.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 15:24:10 -0800 (PST)
Date: Tue, 4 Feb 2025 15:24:07 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] tools: Unify top-level quiet infrastructure
Message-ID: <Z6Khl1rHIAb7wOXw@ghost>
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
 <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>
 <Z6JdwSsAk1xCiSrn@ghost>
 <Z6JksXDRh8OSAh-u@google.com>
 <CAADnVQKmKf6wY3dg+PfAxtrrFWGO7D-m83dEndjWksPfWDt5wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKmKf6wY3dg+PfAxtrrFWGO7D-m83dEndjWksPfWDt5wQ@mail.gmail.com>

On Tue, Feb 04, 2025 at 11:02:42PM +0000, Alexei Starovoitov wrote:
> On Tue, Feb 4, 2025 at 7:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Feb 04, 2025 at 10:34:41AM -0800, Charlie Jenkins wrote:
> > > On Tue, Feb 04, 2025 at 05:18:42PM +0000, Alexei Starovoitov wrote:
> > > > On Tue, Feb 4, 2025 at 12:10 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > >
> > > > > The quiet infrastructure was moved out of Makefile.build to accomidate
> > > > > the new syscall table generation scripts in perf. Syscall table
> > > > > generation wanted to also be able to be quiet, so instead of again
> > > > > copying the code to set the quiet variables, the code was moved into
> > > > > Makefile.perf to be used globally. This was not the right solution. It
> > > > > should have been moved even further upwards in the call chain.
> > > > > Makefile.include is imported in many files so this seems like a proper
> > > > > place to put it.
> > > > >
> > > > > To:
> > > > >
> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > ---
> > > > > Charlie Jenkins (2):
> > > > >       tools: Unify top-level quiet infrastructure
> > > > >       tools: Remove redundant quiet setup
> > > > >
> > > > >  tools/arch/arm64/tools/Makefile           |  6 -----
> > > > >  tools/bpf/Makefile                        |  6 -----
> > > > >  tools/bpf/bpftool/Documentation/Makefile  |  6 -----
> > > > >  tools/bpf/bpftool/Makefile                |  6 -----
> > > > >  tools/bpf/resolve_btfids/Makefile         |  2 --
> > > > >  tools/bpf/runqslower/Makefile             |  5 +---
> > > > >  tools/build/Makefile                      |  8 +-----
> > > > >  tools/lib/bpf/Makefile                    | 13 ----------
> > > >
> > > > Nack.
> > > > libbpf and bpftool are synced independently to github
> > > > and released from there.
> > > > This change breaks it.
> >
> > Sorry, I overlooked this part and merged a change that touched the
> > common files into the perf tree.
> >
> > f2868b1a66d4f40f ("perf tools: Expose quiet/verbose variables in Makefile.perf")
> >
> > Unfortunately, it's already in v6.14-rc1.
> >
> > >
> > > Can you explain how it breaks it? Currently bpftool and resolve_btfids
> > > don't build quietly so this was an attempt to fix that.
> >
> > So I think you will need something like this for v6.14.  Again, sorry
> > about the trouble.
> 
> Just revert f2868b1a66d4f40f that created this mess.

Why are you opposed to unifying this helpers among the various projects
in tools? Can you explain what about this breaks the Github syncing flow
and why it cannot be resolved? It doesn't make sense to duplicate "Q="
in every Makefile anybody ever wants to add to tools just because bpf
syncing isn't robust.

- Charlie

