Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD53E49DF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450467; cv=pass; b=uPzyhEkA23jcAra8IyGRWG+uejovaWvr9mhxIX83n5fLu50EDxrM17vppLphOWo7EeQ+uy5hlVg7KeYcZVMwtEVXz8O3xjpaRfyMslXc4lqHjiWTbrdfjdMxphAgJULBlWXja2BPArAipLLa89OLyG4tVYu3cHXSUYenkc94pvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450467; c=relaxed/simple;
	bh=mxR6zo1uzVmlCvrVVTNLSNdWhxzrwV7OGrG+Af4HFoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTHyVyhV0dBuNyhsNeq8Hvqmjn4XtBMM7iols8kdJx3Uv1bGokWwNiO+elkrhc0TW7CmCpffDbZa7T6qxr/PMJo0hZtPiGOJRGeWMOSWJKj4GyUrvuH7dF7OEK+A56pegE9sU4DmF/Qog923OO8QCOf954MiTtKC+nPrOsSbDK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAVr1pfw; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAVr1pfw"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-848d21bbaffso475595b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 15:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785450462; cv=none;
        d=google.com; s=arc-20260327;
        b=KbaSTF4AD3XG7kV2KyXB4BBxjCDWYfFKWXfCDJw5AZ2alUvofYD34CD/y2w84TzdGt
         j5UGqk4BT6mLNX0Gfa1xkDKG01AWd/x8/gOjkNQEGTvHBdWM7odHSFXN0Jc6armnYstQ
         lZmUPQNcrUAhIcQglkn+MkJCYnTBO+VmQa3vXPeVxvL+Y1Lh5z78flUuj2y40U3Ejy+z
         JIXEjoXEsKn2VXFhg8BR2KOl6MD+0ilwPeVEysHd8Ffi1TENLrQrCxTVdIfamx4HXGFX
         5WwF9R4G2KfiRZ3xMTmExIsbvXPif3g7YM1ErYsX34SInGKboc6Hn/5y/ADLuGgCMFOl
         Artg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        fh=85WH5X+OvzLmHpBs7p4k+hk1L/TGJdWHL915+mf5UZ8=;
        b=JFltqjX4ANd0tGohcJCW0+eW4bib33XI91okUgPw7xJX501vyPLQsMI97ML7sixd+k
         Ps3r6bJFTwmX9mlTUkJSxQBIQyCW7xZucwRhu5w4Q+xCPYIVgd/NI84G+8fONpQTDjzd
         nPw1XhKiXjovhW+F4/AyxcsM5744XValxZaFv4aKgaD3pbS/QZjXuZFBXBxu49GENMYx
         BuN1RGSlmpum1M0A4+qqe08+iN7zhikqQ/rS/SsLjHvT2i+BnR/zP02do2ll+757r/R0
         embu8MWG+o8cFgr2xCbyoNHa8kNqDa3TdkJAsNzVHyp9W9VBnVC3v2y8gRZ3oQQX/H2c
         w0Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785450462; x=1786055262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        b=kAVr1pfwLotij0D/D1LNuSSV7eWURHJKJ9ODxzZVVUGFEJkqaFm+LPBTf4faSM0vOY
         9fNS4/9fB4691cD4z+w0fTFJetWOtE6FTN5yN8WqQh5EZJIqHHKaUjatResq//qoYEN0
         hVXUQ3w/1i+6u8aipLwJZXTDPc4bFRaVFC033swyS9R18K35kYCsKyHRf95dqELAuzLT
         nGnaw3ZwL10yE7cLYjWA7+E1FJiVyucawHXoy6+aQcRsczQOnezCxO9WwqxmAsGyg3JY
         SdTHxbiujsnADkJiN+8mxrtKpubgkfZ982rI2V+9fm797IGmsaxzASE8Q9V8dMHNI+xb
         s9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450462; x=1786055262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        b=sl3K443hqXw7B9bUturxQlFnrgioLZeZ/nRFeFII3e5dC6/NnLvXUyneDDXhSRqgYt
         VNIeSsREr+PMsFvvJUj8aS9b18IrV4dbVm/vyI6bSWkSka8Q6aW2M4OQQL+ppF+e3/24
         Qg9wS9zy7FUEEKneKVx0qBsGpHGhwtgcu5Idqvez/SBsEa8TtLTKoZmPqzPHqQKpKGmn
         Vmq/e6MgMVj/TfeTWbvThvsqqAggJ/kBulH/VtqFBQEUlFfRsd/EPnYBdiTHzsgDuGYA
         s1tal+jb8BMEXsY64ln7LMOSH/OXEQQxEL5S+NDAgHhDLyLy+uIlB9Bg4YyToOk2jXU6
         A7pQ==
X-Forwarded-Encrypted: i=1; AHgh+RowTp+Bd0rWeUUZMBs6bJROyn88ESeJxe3TDCClTRe2ejfXKw+7Owc2mK5aaiy8XsS0iTzj4ZK9rW8PXllU7U88yIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKK36muNDCylRYxaa1bkqL+/3QwWUIRfI+0tLC/UxIyfQqcvy8
	5MKop5VsedYaUHCz+reo3dTFiGwPRvDLEBTJVT1N1Mpb9WHDzwhoPbaj/PmujH1+WFtmN7lsEnf
	aucVBRYtuhyKi2EyJCDv32wLM55RXN38=
X-Gm-Gg: AR+sD134lEQtIfqgF6C+ctpXSyg04lWlwY+VPYeYjQBMVOterctWsR+oe9+cZW3wLex
	BpZHJv6Uf1ljDlge0TrbVgVElOVx6y0M05Wx7UAlxM8yb68LBqZGjtlCCVIEPd0NvYHFjAtWfi5
	C+BU1X41yerpt1g/3tDaauj127f8jg9nRoFLUk+Q1P99O1w86saXgDPC5E+4F3HgEu1IhQizXLj
	QJug72ngBfIoI+4wFfvRNIndLappTCuPiK2DuT0+SkN8lfjDSV0nwE7XCaVDI7prJuOxEiz3+r6
	BqeokxiRqp7FiuG/q25pLKMGN6SmOCdaRU98+SK1w+Kz8ZxlyK0KNsEwfiho/4Bsx8Yw9Lozqir
	tbskRRknDArX9PFVSszHnb10/ZkO7ViKHIjWKkDD3qqSRuUJ4aVGyZvO2heGA+nIV
X-Received: by 2002:a05:6a00:c82:b0:848:4754:28e5 with SMTP id
 d2e1a72fcca58-84ebc1fdaa9mr3988166b3a.16.1785450462053; Thu, 30 Jul 2026
 15:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706172744.3920417-1-puranjay@kernel.org> <20260706172744.3920417-3-puranjay@kernel.org>
 <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com> <DK4I97UIL347.3P2KEBO828JK8@gmail.com>
In-Reply-To: <DK4I97UIL347.3P2KEBO828JK8@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 15:27:27 -0700
X-Gm-Features: AUfX_mwDesWtdCLE-1Fw6wnAI4608m7zqiXpKFs0ROJhEZiKm1s5xaCdqqVAUCY
Message-ID: <CAEf4Bza3LeVB-z3jwMdnBGLdjpPr9tZFhGHt5pUwui64ZX66Lw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to SRCU-fast-updown
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 12:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri Jul 10, 2026 at 11:23 PM CEST, Andrii Nakryiko wrote:
> > On Mon, Jul 6, 2026 at 10:28=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> uretprobes_srcu currently uses normal SRCU, which issues
> >> two smp_mb() per read lock/unlock pair. This overhead is
> >> paid on every uretprobe hit.
> >>
> >> Switch to SRCU-fast-updown, which eliminates the per-reader
> >> memory barriers by moving the ordering cost to the
> >> grace-period side (synchronize_rcu() instead of smp_mb()).
> >> This is acceptable because grace periods (uprobe
> >> unregistration) are infrequent compared to reader-side
> >> uretprobe hits.
> >>
> >> The updown flavor is required because the SRCU read lock is
> >> taken in prepare_uretprobe() when a return instance is
> >> created and is held until that return instance is finalized.
> >> The traced thread returns to user space in between, so the
> >> lock is inherently released in a different context from
> >> where it was acquired: on the normal return path via
> >> uprobe_handle_trampoline() -> hprobe_finalize(), or from
> >> ri_timer() (expiry) or dup_utask() (fork) via
> >> hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
> >> are designed for this acquire-here / release-elsewhere
> >> pattern and, unlike the same-context srcu_read_lock_fast()
> >> variant, do not carry the lockdep read-side tracking that
> >> would warn on it.
> >>
> >> The short, same-context SRCU sections in ri_timer() and
> >> dup_utask() (which guard the uprobe against reuse across the
> >> hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
> >> for proper lockdep coverage.
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> ---
> >>  include/linux/uprobes.h |  5 +++--
> >>  kernel/events/uprobes.c | 29 +++++++++++++++++------------
> >>  2 files changed, 20 insertions(+), 14 deletions(-)
> >>
> >
> > Very straightforward replacement and will improve performance, thanks!
> > LGTM. Peter or Mingo, I assume you guys will want to route this
> > through your tip tree, right?
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
>
> Hi Peter, Ingo,
>
> Gentle ping for this.
>

Another ping, please consider applying, thanks!

> > [...]
>
