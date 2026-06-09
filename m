Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B33B42CA
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004402; cv=pass; b=sAq4Df0P2xBtpwoZOdn50K06lOBNB+xPVei60TJvVrZG9OLotLDIkDLLB4UwdFIoq+hRUhhLfmp4CQCFfwpmNuQF4Xa3GWPTzbP3mzE+AT0IXSfUjhmaEORBd1oxb7RbGEBxdou+fb1vOu7crrnhdmU5jAXGHSBwIAUxnGpQuso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004402; c=relaxed/simple;
	bh=oGrgWxDQ50CGdoglt0lBrW2AkIY0C5vX3eNUw7J91ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFi4vnv7ILoeEeti5VHh2BwCBsiQStinqDd0Vdy3QFNsTNRzD4bcyM+diatxRNgHJZriJ99pDd5rHWlftNNNxkE3XlzovkHRZlV37X4NJfazKxZ939np04lmpcJof8q3e+Azv60q2rOso/Fch8U/0pnEbILc2kwqfEWiswv++Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Qq+LrsqN; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Qq+LrsqN"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68d9d56fso5434961e87.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 04:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781004399; cv=none;
        d=google.com; s=arc-20240605;
        b=Md3SreOMWrD41HhgSmKryXUzZ6xC+rnhzspboDNIoaoUEgjIHaB1G+qMse3XMjXPmR
         XiEfu2K80sDgaj5Ow6JkmcbemTv2G7fN0p7oV4q6uRJa9fNPv0y45a/mCwbC56R6JvSg
         ydvMqDzFIPKZyoQWVV7pfKemtxkhI3cbfN1Ddv2ubcuuVgOfiBwUihOhyUQdheB4YinI
         aIp6zwwx9jokU9TRhpcTFNMIRBQXr0Sci2pnX48myk69z4N7pgoqOyTjhjr3nnRxkY/z
         gmGDigPUZmF6MUGmcniP8B3nwSLKM7t3lAXoFiF6gTly0o37spEQdEuL46FLltXPbJTa
         yGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sjk1uQj48ajhPBtSZ+PDwQJeUr5HpfL1QsJxcIwIpGk=;
        fh=Hl7PcCx3uBsOK/l2bUCLH70CJ/zEu6580h6cOi4uiFA=;
        b=jgAxcfw/F8bPV3m8I2pJXcGpJ3T1E5mY0rNufEliLtft/sEkUOlcCkG6Ff4ilph+xw
         bv+/8WZq/0HO/gQd3ujy1Q0jroiCcxm4c/Fy9M4hN0eUG874XI7nL2tYWrRmxdDZ2TzR
         c8IGSa5qffruy0OEMLGuA+dy9tjX8kOe8iRIcEMWusB+YuP7+C5fOOi10R3IDVfg4vfI
         VRVytmq/B0weYwK0sEWzSiQwOCalm/ntKV+jBe3N/ryjUmvwj7zLBrsNXM/c718Tgmak
         n6bVUpoeOBeffye/dBYPtFXbFfsh8Zac9p0EZz9AwzJdpuj5T8T8y841dA4GCgkt3v/E
         FWKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781004399; x=1781609199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjk1uQj48ajhPBtSZ+PDwQJeUr5HpfL1QsJxcIwIpGk=;
        b=Qq+LrsqNtcA1gXY//IKKAHlCyPqaUYcq3XGgFvdbsnxCLiKKlfPl3KKDBbS2rOJ1w/
         mDSJ6fdiJeZkF8CkpouGmhwaF4fEY/im1pn4LnI5ocHD6mdnmwBtFfB6PN6DTosjQcK3
         K/1HflxBqmXYuRdGlNOcZXqmg+bfWURGuaABHi9N8Sk4toGF16otzmiD7Jchkkr6h12n
         G1pjp1VRObK2EgkQpqwZBYuXpPNADlFTYWq56EQb2jeVQApjoDWwsghh3ZkQMEX5cwNK
         DYhhkGwKOYE6g6ja77Ql/pwmt2nxRTI6FIm6toncLtkZeb1QQt6CGpIPLJLYnAPT4vJw
         alGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781004399; x=1781609199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sjk1uQj48ajhPBtSZ+PDwQJeUr5HpfL1QsJxcIwIpGk=;
        b=Nso9L/DwdGjBzzr2RKqwxvx2sKMOuFU1w/ogGeOlzhndPACZapKRAtsPjSs7FsFYj7
         Rv0Ar3R5SLq5uQW7wzW0ZlTkqTx8u2PSsHAWhRNScKAYPIvmZxOok+RbEEmP4qpCOPIr
         IUnqwuKjkojTEDETP3yQv7oepZk8CxSZQB9Rhww6ksFXUYj0cJsO1Is5SRR0eDCytjbk
         L4xdfZQ0ZiJoup/Bm1+AVSa0oNss9GX7suTmKGVoqYBL7CA/n2nEaZy96JYN9B1xlFjB
         qAdSTlQvdaa242fXLLeGc1VdbNjg5hlmdRA416CQwx7K7IAU8pazf0T6IYxCQNxZ6dxO
         E0ow==
X-Forwarded-Encrypted: i=1; AFNElJ/3GNMjyPPQPdxAw12qMGYpIzcHknyIuD5UIlA6sXvkh5IbRK0UUv/Gz7VhiqFiUmAw0IEHsTPdQaMiqnxiXTCbG14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjgt4Wie/QdfGdoSRB8VainbnyNoZO7RJz3LS3cmZjQ0x0Y67
	X38YWDPc5uJIjlFzsbyi/Nb4DYTfhBZMLLVAuX+lAz2ratoe8f2p6crNgXTBntEC4QJ5hrNMMWH
	GVk8cu3yhNJCsaO3trrMzj4l/hodfwtrieAxVCuxy5g==
X-Gm-Gg: Acq92OHKmVV0DjEFAAsN9GH1TJV+UquJQ1Z/8axiv9escqn7AXVNRNhhD34xVKeoD/j
	ESLv6GeP834qEcglPS4q/kJMk32KaL+tgLMjWYlzFosU/Xyu4Ol2Zo8gRGuzz2kZOVNcrsXiVpa
	rX2Fah03s4fq5de40vf5WVByvuaCKfn2SLJGFbSiDbM9VjQ/2s8rK2ut1tLrrkxXp5WVpjA7OnD
	JqFZw/44Na1zzgEQwQbqUYihlW2wBtaIjfIqECIsTu89DTVRqIAcWJUgRhrKhv68i+pYS8TReDA
	cc1hDvnffdAIgT29ky5GouClqxs=
X-Received: by 2002:a05:6512:128d:b0:5aa:6636:ddba with SMTP id
 2adb3069b0e04-5aa87c13a36mr6122776e87.38.1781004398723; Tue, 09 Jun 2026
 04:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609004422.1239735.f6c06011af32.ftrace-ops-zero-function-calls-div0@trailofbits.com>
 <20260608210324.6af37e65@gandalf.local.home>
In-Reply-To: <20260608210324.6af37e65@gandalf.local.home>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Tue, 9 Jun 2026 07:26:27 -0400
X-Gm-Features: AVVi8Cfe9kqbl_u-q_FTRCVb1A1UC-v8Rp_bNQWH0PL7a72t5Z0I0BadRamaJkk
Message-ID: <CAE+C+DZXcQfyQt-UV2PRt0vVFJqCciW6QkyEd9FaJ8++B3M4Ow@mail.gmail.com>
Subject: Re: [PATCH] samples/ftrace: reject zero ftrace-ops call count
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	"open list:FUNCTION HOOKS (FTRACE)" <linux-kernel@vger.kernel.org>, 
	"open list:FUNCTION HOOKS (FTRACE)" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue,  9 Jun 2026 00:44:23 +0000
> Samuel Moelius <sam.moelius@trailofbits.com> wrote:
>
> > The ftrace-ops sample exposes nr_function_calls as a module parameter
> > and uses it as the divisor when printing the measured time per call.
> > Loading the module with nr_function_calls=3D0 skips the benchmark loop =
and
> > then divides the elapsed time by zero, crashing the kernel during sampl=
e
> > module initialization.
>
> This change is rather pointless, but whatever.
>
> >
> > Reject a zero call count before registering any ftrace ops.
> >
> > Assisted-by: Codex:gpt-5.5-cyber-preview
> > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > ---
> >  samples/ftrace/ftrace-ops.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
> > index 68d6685c80bd..d5adaa61484f 100644
> > --- a/samples/ftrace/ftrace-ops.c
> > +++ b/samples/ftrace/ftrace-ops.c
> > @@ -190,6 +190,11 @@ static int __init ftrace_ops_sample_init(void)
> >               tracer_irrelevant =3D ops_func_count;
> >       }
> >
> > +     if (!nr_function_calls) {
> > +             pr_err("nr_function_calls must be non-zero\n");
> > +             return -EINVAL;
>
> No need to print that the admin did something stupid.
>
> > +     }
> > +
> >       pr_info("registering:\n"
> >               "  relevant ops: %u\n"
> >               "    tracee: %ps\n"
>
> In fact, I would just change the output to be:
>
>         pr_info("Attempted %u calls to %ps in %lluns (%lluns / call)\n",
>                 nr_function_calls, tracee_relevant,
>                 period, nr_function_calls ? div_u64(period, nr_function_c=
alls) : -1LL);
>
> and have garbage in, garbage out.

Is it okay to keep the same subject line or should I change it?
