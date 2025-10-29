Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B930E82B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722232; cv=none; b=psWwjkYJaGqk9om7b+0Zs1rJoJoza4eEOzAHBG9dL3yXcBviCURw1Qg8pXhazzeID4wSR7SFQlloS7f/bxfJGQL57eFGuFwZ3GBpNpHP7S8YVPwxjzcKyq1WtT4Ujw0KF9czTFopjjbNFArS0NCD9JUKKlXIoTWscRt7gEFfepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722232; c=relaxed/simple;
	bh=Alikw8zU+RHR/VW1Sf1dHQ7s7eeYdPHAeuE6O8+xV6Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwT6E83yOm3xGG/UBw7epcrMVZbm/f+2fx5PZi4xW/Udde4wV9wVf2BBguT/S7Pz+A82dUuwS9VpM+D65/2uFCGADbU73xmxdLDd8mLNBSVw9FZsVr7mCkl8KtqLLD23AbVWDhGEGyguXX9h/JIgv9lvk9v/5ZTJdDdnSUOGCrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCaoo3sf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCaoo3sf"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-427007b1fe5so5720722f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761722228; x=1762327028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANikBWzjiXtO/iPDXPdp+kNg//oko4JK3XBqiWoU92c=;
        b=JCaoo3sf0l3DUJw/GViMnml3xde66o8dDvdu/EnSuNHqvEIOQrq3OTlqWmuNdSFRH/
         +OPQgIDtoez9PgVPaRiupJ39ZIOVpspXf+d9RIaovJwDVbGbjgd7gZU60VsYJMvlxs1J
         +Hi+KIDjzJ6VQxGL4//cZ6v70dC+e6+Uny+ZCXLFAaT+5At//t8obgvS376C3t0C6S3U
         tW81Q20shmk4F2l6FVdy7vwG0S/3dx/4CtA8NOlUsrDGL+DzLkATWU/ubeVniXv0TCh5
         e9l8QYKbsdEcgHmgUXcpGXxRpfHmQ+OiiNxnhOTIKF9y+MpkRFHFu+KD4dFb250QIIHX
         UihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722228; x=1762327028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANikBWzjiXtO/iPDXPdp+kNg//oko4JK3XBqiWoU92c=;
        b=cIt4vKfxE2POtRDJhUjLRtAARTvbvmA51R6dVzY0vJkvr+mRlRMU+MJLo9ILf6MOfn
         cLJ/r1mfQGMS1bK6I5Qku8CCymvCjD8nMsFt2zfeXwwattFxV2sNXxeKplFb+lkHq7ri
         p4UXXGA8j79YzBY+vdVsFgqp6UhpJ8oNhHwe66jpV+l8EUiQirI0sjVUIwP5RGdNhWLq
         /22ubDBGJvEhfOJCZd2GRGKE4PaztKCeH5wwVdAnJrtbO2KLtPBzAm6XG5/v/4f8Txpt
         6lCr6hz8xTC4fHK+FnfaVk3ifsASLWqHKjc6iVMjC9aeNAARA563zkDB5Lk7p9+skSHc
         63SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgExknL54H+i695dIXb68fi8FqkGRnfLB79f+e1gI1iTfreg1JC5XKhc4KCOtqZjZUiQt0DxQpD9mN99WlCHbGUsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8VUuSjluJ0maJN002WZ2zjaZlvqvlWiyLasjwRUQ1Q1sZgRNo
	pJq6dEWUMFwViW+Ul4/sC9OPyS+PkBXT9TiNzJJrwC8eGSY+DWgorHRO
X-Gm-Gg: ASbGncv7gogJj3NSTGzOkGUvA7kBBvvumbt64G7xGEm7SilDALe1UEbTvvWp2RSJR8a
	pKCPcb5u6SpiIVZdlkB2epco4vkfaw4hF7VFCyR8CnVRAOL+V4jRsc8DYUnI8H3BpNSXLuzWPsr
	G6oNQW0g37s4Ww6L+Rd3BPELds5YOKUOl6sJbisTh54/7/YklQupP+cyLaVGF1JdOXfNNY0nQN8
	9gw2Mx5NdiK3FGXGO1oHFzBI4TacJBfN5o1Jckbe50WpI4cG+UqChATPXc3xjey3e5y/2pwRmts
	SXtJLLZnaQTlTI5MN5K9RFszc4DBQLIcUB6S/ntTLiuWF4OxkX9P+S3Pjh1Bk7NKMPhfiuLkBEi
	+TRfAXwXxx0kv0J54I7nF0qM7upkkV2l9VvVkMX0LfMpZv5UHNQ==
X-Google-Smtp-Source: AGHT+IH4p1yq4zEhj2eqFa0BCgJSpxFayT0Gt74ozNY+K0O0sM8HKFMIYGpClVlqn1Aonb1DcOa74w==
X-Received: by 2002:a05:6000:1446:b0:426:ff2f:9c15 with SMTP id ffacd0b85a97d-429aef735eamr1737371f8f.5.1761722227880;
        Wed, 29 Oct 2025 00:17:07 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a7csm24793511f8f.8.2025.10.29.00.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:17:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Oct 2025 08:17:05 +0100
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, bot+bpf-ci@kernel.org,
	mhiramat@kernel.org, rostedt@goodmis.org, song@kernel.org,
	peterz@infradead.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
	songliubraving@fb.com, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <aQG_calHM0E7ou67@krava>
References: <20251027131354.1984006-2-jolsa@kernel.org>
 <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
 <v53j2leswscyunqmrj5zvr3bsdafxlze5z3yp4hvsd6epbvdvm@njx4yhpkqoiz>
 <aP_0eh7TH2f_ykhz@krava>
 <xnx66p7w3qstst4ixj356dnzexrpsjy52tfwthp5kytv5yagcf@4ngtq5rrgqzj>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xnx66p7w3qstst4ixj356dnzexrpsjy52tfwthp5kytv5yagcf@4ngtq5rrgqzj>

On Tue, Oct 28, 2025 at 08:39:33PM -0700, Josh Poimboeuf wrote:
> On Mon, Oct 27, 2025 at 11:38:50PM +0100, Jiri Olsa wrote:
> > On Mon, Oct 27, 2025 at 01:19:52PM -0700, Josh Poimboeuf wrote:
> > > On Mon, Oct 27, 2025 at 01:52:18PM +0000, bot+bpf-ci@kernel.org wrote:
> > > > Does this revert re-introduce the BPF selftest failure that was fixed in
> > > > 2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> > > > still exists in the kernel tree.
> > > 
> > > I have the same question.  And note there may be subtle differences
> > > between the frame pointer and ORC unwinders.  The testcase would need to
> > > pass for both.
> > 
> > as I wrote in the other email that test does not check ips directly,
> > it just compare stacks taken from bpf_get_stackid and bpf_get_stack
> > helpers.. so it passes for both orc and frame pointer unwinder
> 
> Ok.  So the original fix wasn't actually a fix at all?  It would be good
> to understand that and mention it in the commit log.  Otherwise it's not
> clear why it's ok to revert a fix with no real explanation.

I think it was a fix when it was pushed 6 years ago, but some
unwind change along that time made it redundant, I'll try to
find what the change was

jirka
