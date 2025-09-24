Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8E309F04
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724629; cv=none; b=huUpJ2x9cNCf0M6bfqQQRCK3iav4p8A3NbcxiXfiIGOHK3Jgk0HYA9w1wtKtvlyjKozRumcWtZN+VpQOA03HvP2dCPYCvYNcWa+fP5a8sO6PCrs/t86PoiWOuO4/4M1Yq1+aY78kfoR3uKGjbWdWeE//cC0mn9pD60uUu/sBSOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724629; c=relaxed/simple;
	bh=sIBMYcw18+Ht8eXVyZ8dR0xLQoQqWvukpqCuFy0av6A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFRUec/z/F8SGZYYdBlhDB5YBpG3muC6iokpQ87AcmI2VsBfvmSVoibYnO32m7r/7475PlZlAiABRnFKMniFkYRPrGAQNb/z3HDYDA304j0Sl0Skm1Jw7GtJvZVc9eXP5f+N0lcmAlCdD38L4zIsFi5WqY6GUjh5GmF8jV8FzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL7VXdKB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL7VXdKB"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ece1102998so4396502f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724626; x=1759329426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5HShbJ4pb0uvOuUwE85U36B7c1llkadxegnV9SHJtyg=;
        b=XL7VXdKB3JM/deiApRhDlMQkiHB3F+D7w6mocXHXJiUGYZnVQ0rZTVfA+oM1vT+O5s
         r8Ih0w7Mgqmieo7PAZGGcFX2pyHQgR1iSYN+hpI7HjRAhv/bQ49BJFHVnIU/u+KgkK06
         5+a/iAnEmeb/+1wCzXYYyqrkyQ3XIwvn+3uH7NqhIZH9HNGzG+DVMvle4dk+N8sxhy1x
         n/JFrYrqDMLpafKLwjTRBU1guVTcXqv8jVkz9E2LUGAHmlWj2MKkOh9q2k+BWBq3HYKh
         Tax8e5bxHbk2PN2u/zoRIJGFKHRKB1yPpt8F7etb+VlBjr8LIClh5xyphPnLsSdwrIqM
         X9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724626; x=1759329426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HShbJ4pb0uvOuUwE85U36B7c1llkadxegnV9SHJtyg=;
        b=neKsLFOn1yQXiBij56yz1BzMouI/TgYlnUx+6WW5iyiWhdIkgN95b9WbOMnoWiQiu0
         HXs00epF5YxfaMSJ1clbx3vPrLPgXwME+Ky/rt/G7NV0FCTsXh7jNQyOsvyI40OcZtiC
         XPs1AY8EScgXQfOwWbF7EqpBGlvIQbUl6FOx0/TZwRxY+efRq+hp3kTdByotmoJq1KBN
         yx+AF0LE/7wCgmROHyZ4R9oeS5Jfj1xvRIS03qxW62059pVZtehPr0RNn4md/6oC9Mgl
         Qp566S0/hnxpoKdfvnon+1W6bnua2kxV6UniXDuJ3KptulnHo+cTnM/rtpl9kbVSunY1
         VRfw==
X-Forwarded-Encrypted: i=1; AJvYcCWJo1HNEXRAzW3Yn5vNG6JQYsfhLLenCIp/mm3d6TqE6Vs9tefNMlnYBbtm75QWYAAeuJRAZG0NifxBdlMmbTIaTLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPW196ENqDFG75mvz6arG4c/nRiI6sZSyOZYinc4lWX+kYXOb
	jlRsqyb/qDXan81aYeQnkT2LkE7oZJakFEaIAD5wZ8fYdTDkzhpfmdby
X-Gm-Gg: ASbGncsD9JBG1jRu/g8dlzLpU/GSZ7OjSBV5d+C+VgA5L8xwjEBLQTxLKPqwOglg7bl
	a8+ua1tEyq16vIP+ZEdrcUFNjKc91tZ02+fmSVtdqKaPQ2SG12DyeEuR2dLNnlgWSiPt0D37vSm
	t5VkoZpptdaTNms90F46YjTbJihzPhNg8dfzTRadw1a8a8x2zOe9x45RUg1QwFZ1rPBo1gyCR4g
	0jkvxvOF5td5rfAJ4UcrbbG6EHpou9iJ2SNK5hAi31gwyF+TLwWd1+FzBMfRDQgDksktfXEWv3g
	eJMxjpOczteheZEedi02IHlRx8mojW5qagFyu26VmUJOJkx2U/C1mXWQ0iTIrdBMOuPdhOtH
X-Google-Smtp-Source: AGHT+IGEO49EkOTURq2dd80B/jZaZg6Lr95kVlEuO3QoAtObbHlJjeJCYscX19kjXmpcKNM1wSiX9Q==
X-Received: by 2002:a05:6000:3105:b0:3fb:9950:b9fe with SMTP id ffacd0b85a97d-40e48a56cb5mr155880f8f.47.1758724625481;
        Wed, 24 Sep 2025 07:37:05 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fb8ebb0d91sm15724812f8f.54.2025.09.24.07.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:37:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Sep 2025 16:37:03 +0200
To: Steven Rostedt <rostedt@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH 2/9] ftrace: Add register_ftrace_direct_hash function
Message-ID: <aNQCDwYcG0Qo00Vg@krava>
References: <20250923215147.1571952-1-jolsa@kernel.org>
 <20250923215147.1571952-3-jolsa@kernel.org>
 <20250924050415.4aefcb91@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924050415.4aefcb91@batman.local.home>

On Wed, Sep 24, 2025 at 05:04:15AM -0400, Steven Rostedt wrote:
> On Tue, 23 Sep 2025 23:51:40 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding register_ftrace_direct_hash function that registers
> > all entries (ip -> direct) provided in hash argument.
> > 
> > The difference to current register_ftrace_direct is
> >  - hash argument that allows to register multiple ip -> direct
> >    entries at once
> 
> I'm a bit confused. How is this different? Doesn't
> register_ftrace_direct() register multiple ip -> direct entries at once
> too? But instead of using a passed in hash, it uses the hash from
> within the ftrace_ops.

right, but that assumes that we can touch the hash in ftrace_ops directly,
but register_ftrace_direct_hash semantics is bit different, because it allows
to register new (ip,addr) entries on already 'running' ftrace_ops, in which
case you can't change the ftrace_ops hash directly

> 
> >  - we can call register_ftrace_direct_hash multiple times on the
> >    same ftrace_ops object, becase after first registration with
> >    register_ftrace_function_nolock, it uses ftrace_update_ops to
> >    update the ftrace_ops object
> 
> OK, I don't like the name "register" here. "register" should be for the
> first instance and then it is registered. If you call it multiple times
> on the same ops without "unregister" it should give an error.
> 
> Perhaps call this "update_ftrace_direct()" where it can update a direct
> ftrace_ops from?

I agree the 'register' naming is confusing in here.. but we still need to
use 3 functions for register/unregister/modify operations, so perhaps:

   update_ftrace_direct_add(ops, hash)
   update_ftrace_direct_del(ops, hash)
   update_ftrace_direct_mod(ops, hash)

?

> 
> > 
> > This change will allow us to have simple ftrace_ops for all bpf
> > direct interface users in following changes.
> 
> After applying all the patches, I have this:
> 
> $ git grep register_ftrace_direct_hash
> include/linux/ftrace.h:int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
> include/linux/ftrace.h:int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
> include/linux/ftrace.h:int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
> include/linux/ftrace.h:int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
> kernel/trace/ftrace.c:  err = register_ftrace_direct_hash(ops, hash);
> kernel/trace/ftrace.c:  err = unregister_ftrace_direct_hash(ops, hash);
> kernel/trace/ftrace.c:int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
> kernel/trace/ftrace.c:EXPORT_SYMBOL_GPL(register_ftrace_direct_hash);
> kernel/trace/ftrace.c:int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
> kernel/trace/ftrace.c:EXPORT_SYMBOL_GPL(unregister_ftrace_direct_hash);
> 
> Where I do not see it is used outside of ftrace.c. Why is it exported?

I have bpf changes using this that I did not post yet, but even with that
there's probably no reason to export this.. will remove

thanks,
jirka
