Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235829B20A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080404; cv=none; b=JAyMqHS5idbi6CENb/t60nFHprS1e2cY1w+i98dGkldYkgvnE6xW4SkYV8SN47lFcPzZ3Jo056/7Kij5kz4ytt1sV3fyiXa0x4BV36JT8GyueRsm2gJpfMIDNwJMgxZLhIxDrJESiVrltzA+WUbZetaYaf5sJpRyaI5sYpQ9Lg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080404; c=relaxed/simple;
	bh=SVUpaxhc/WIBfNSCedhE5+nKIJK1oRK66sf/5MKTEmI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIHaORKlzaeIAtCEx+4Onkw3LpoUQmnZ5jAyz98y63SyeSpvCO143U6enesb77gxDLD+QyRerUEV3NZp/zK1E1bY5twqcPZcFklHJn18Vfv1nrd8XGh/oFBPCm7lAGOwyuchKgIZ2MOAY2l0WiWP+9ik4vvpp9zmZ9DQSZeOuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=I49Qht4C; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="I49Qht4C"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92ed19f4d60so33379485a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 15:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789080402; x=1789685202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GBU7hvidTKCJV2Nv+RIrUVUgoddYnQKNG/JROhtpIDU=;
        b=I49Qht4Cpz/sL9rBGh8wxvxgUJk5xpheKdbRJ/4xKgeY+pq0nnumHLLHSGY530L+v3
         INjAnNeeR9jL4Kx4wB8wsu3BNcizeEN8wnquaR7cTB8TCmwiOP5qPSFz0yi8biBWChHO
         3u3821uJ2DUVuP0UFubWPvrqYdwYb8Q7QKl25txTHnp7WZh2QfmeGcURolyy2l0z4D7G
         XfhtUYwXe2vGNNyeYZwkMonwW+hKS+FncBWaxHfwX7i+GqMVfo6/8gl28Rxb1O+hDNKN
         kF9slp3oCZrdB5Z4o6bmdJiR3lYG6cBzGDostK4mrlh46hqQMuWRh40800hHWIAxmecV
         F9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789080402; x=1789685202;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GBU7hvidTKCJV2Nv+RIrUVUgoddYnQKNG/JROhtpIDU=;
        b=f7swOgsq5KZm+seckkoAj39sxBtTVGWwzbzfFmqDIdFWmcEbOGOpKREZuffwNXnWY7
         TdUpJWitrqZYcLXgd2Q9FEysCxikdyAu6GshlF4Y2kOsv6o0zGPTJl6dbMse/9GOtH1/
         05Qu51jnZYdYs5r73uMQGjhglscrcEhiIErTiNdaH5uNHhZwW62EDx0qaWuGeEB8YIC1
         Try5pIKMZ6zNkuwzIUy3kbVmD1B0bPjzs5K2rq6okylr75qPgccjilICOgKZU4ZkZ9jT
         fykWbsDuEWkbHuSrm10xpJTLFy/HRIt1+HsSdFBQHu3JzExxX3IbqL2G3ZmIvLpE66Wf
         5EMg==
X-Gm-Message-State: AFuF++n2um6pISnNxPdBIJD6Tnxn1Z4bExB7VL4w86DUeLSWGA/PpZQW
	U7GQLpzpjSdUc9MDDTK2kR21DNnLJxkXNSTdnavW7dzLSPLmO46e5+7wPEy+AtvtZscFBIB0k7N
	D/NpE
X-Gm-Gg: AYBFou0e9hNr9hDz19ESRmlMtd+nnozY03djX6y4S1F8b58MkfMtZo4YYDLOnzDxBX0
	C1sMq6ixynXfvCo3GL2Z3nSRhKCiN+VxqDKs3azR6uaz6Qckwgnu6vlFJGvkHf25t/srW7ga7bh
	7+MqhicPG4Ze1IOs8LYrocIoGoLgyA3+ePFBKLQq302UYSAGKRIGlyBTOTH9rpRq9XkFmdqoAcj
	YYhQEej/w7XD7DZ9I4iDQgyBybV0IPkbGwjuj+C5PHY4+5ffVdPJpQBnSeYDZ6MVX97xtFdRp3S
	y3QiLyIqjRJ+5Sq0RuNul3qXTGfAi5Hufe5Wg8bs0jtgf3h6BEAlIoe2TD2660X0W9KAsK+CT8L
	7xZcFpTwRq4AlC9bIrM0TZRvSWy09670WtNpfUmmAXmbMkfZ8ffeFYrZp6WhIQ58X5IJ+9tw45k
	az6I6bA2rxYlxy0lQyjBPc5ODCySbdMwK26Qy21y0jqyohFtA+lNrsHv9V4C6ezPpbURmud40Ti
	Wywv8q+XHRzCOI1N0agMq5pTFAS1Qy8dy7KZelYw7kPeSyNUPph41p/OmesmVc2tSU=
X-Received: by 2002:a05:620a:3182:b0:939:75b2:8844 with SMTP id af79cd13be357-939d7fcb1a2mr822789185a.35.1789080401713;
        Thu, 10 Sep 2026 15:46:41 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e809fd0bsm91246585a.33.2026.09.10.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 15:46:41 -0700 (PDT)
Date: Thu, 10 Sep 2026 22:46:38 +0000
Message-ID: <e44411503b3696cdf003d3e46bc54fc6.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC 09/13] arm64: ftrace: Maintain Tasks RCU trampoline nesting in ftrace_caller
In-Reply-To: <20260910190436.EBE3A1F000FF@smtp.kernel.org>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com> <20260910-b4-rcu-tasks-preempt-qs-v1-9-d4469f4cc101@toxicpanda.com> <20260910190436.EBE3A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 19:04:36 +0000, sashiko-bot@kernel.org wrote:
> > +/* End of [ftrace_caller, ...) for arch_rcu_tasks_ip_in_trampoline(). */
> > +SYM_CODE_START(ftrace_static_tramp_end)
> > +SYM_CODE_END(ftrace_static_tramp_end)
> > +
> >  #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
>
> [Severity: Low]
> Will this cause a linker error when compiling with
> CONFIG_RCU_TASKS_PREEMPT_QS=y but CONFIG_DYNAMIC_FTRACE_WITH_ARGS=n?

No, that configuration cannot exist. CONFIG_RCU_TASKS_PREEMPT_QS is
def_bool on ARCH_HAS_RCU_TASKS_PREEMPT_QS, and the only place arm64 sets
that is in patch 13:

	select ARCH_HAS_RCU_TASKS_PREEMPT_QS if DYNAMIC_FTRACE_WITH_ARGS

so on arm64 RCU_TASKS_PREEMPT_QS=y implies DYNAMIC_FTRACE_WITH_ARGS=y and
both the marker in entry-ftrace.S and the arch_rcu_tasks_ip_in_trampoline()
that references it are built together or not at all. At this point in the
series (patch 9) nothing selects the option yet, so the reference is not
built either.

For the tool: the two symbols are tied by a Kconfig dependency introduced
later in the same series; checking the select conditions across the
series would have avoided this one. No change for v2 beyond a note in the
changelog.

Thanks,

Josef
