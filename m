Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029304E36FC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662931; cv=none; b=FoApmY2PjKLuS5NFWkuZF3Dm00mV860hoSKAUAdlek2qg2/wjg8/Ad3ZVQkPnoitbsHV5Np0DJecldWhKuERjlaIFgqcnyJxJZmbG1PY0kD07PdagtVI4yb4uUQU9dT6qlNsmTxB9sChTwIhnYhHWyUFgINa0NXQ4iLEwHlo+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662931; c=relaxed/simple;
	bh=QgmhQmszRFG/vfc4SQJB1/3XDJxm8LGwggD6bEqDTmg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnZUSfX7u/I33+/OUeXxOOlk5axGZOIM2zNx8LdGZFms8uN1T9Brgrd/EFKvKnoUJNRGKSxtAQYpXX8cbkVXRbLrNhVt6wkXl2ROGI/gDeJi+c3jNH/KEV95IS4pn7E1YZBjZ7irdJYKSSq68ks1DQqZaKfT8qCM1Z9cvHeqZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=LuM51xkz; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="LuM51xkz"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-532910016beso8965371cf.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789662929; x=1790267729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BF23L7IjgM1pfHyM3ghg4jPhGbV/DtVtyTw2lo+n/XU=;
        b=LuM51xkzmAaOcyQO6PRPefCD2IUxYQT6stDb8ZVHLROTPhEUuc2vBl4F86rmGvBLPm
         D9gDj94gfkeOQ8qx3DosrHXRPdS9mtpAzG07684+KfGg4N9ucRAuw0bpthVZkojarv0b
         sJsMFZXDCEAgJvBZRBiu0kkMv9HtohKo2yc7z5TfhWdj4BStarX6VUMcJpc3ocvi43s4
         2a+ot/MLV2YnufdCKmIczlWJ+sAlTm23mkavayZtNtHNuiIkH8Ol/7WNRpf4lLwz3BUo
         4LKiQZ4lhAKDfF1efbEIUq1y6ElZII3YzpkzqF2cLv8D926TqKlVlL7qf+ird7QcS6wd
         eAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789662929; x=1790267729;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BF23L7IjgM1pfHyM3ghg4jPhGbV/DtVtyTw2lo+n/XU=;
        b=TFiA4MDcc7rqoWKMsxyo/o+FdRrAplLKW+cVTryfej2v/8N4Ruin7JCFW+UN/0UOqw
         G40aBPi8i3IR7JzSfc6NIhc88TgF/m8tawNl9IoTyJgW8nFrFIfNtX1mEZeH3rRpnZCD
         UNlG0PeBSe9aUyNF1XnOOCVcn9N5VpLpuKufvTwgGoO9rxBDYu/qrU2lG751saUjFwtU
         gvmbigQVwgH6TBKpa2hJR1/PqANJ4PmJy5mRGR9C6yYTyR8xhC+5rQjG6QpsIa77JliD
         UN7ALLAhkOAxJiWa3yTkw5OOI4fy5CeSmcNeLwRs+BCjkPZ0Thu2n8T/rk1gQGsfgpCr
         xPew==
X-Forwarded-Encrypted: i=1; AKwUvBxqzdyqn4b3COCN0VfqHu9dTB1BUvBsprZEj08luwIlvrtIYLzv2hYDlOs5oEwKIfxqNsjbI2RZz0By7XHuqXsYg7g=@vger.kernel.org
X-Gm-Message-State: AFuF++k+wYJlF1VMrq5zEwMpRostx2/aTbiYdcrjxPFKuQg2ldbY8fsD
	WvBguRt7toWUyUV5Y32kL37jw67Dx3d2c/BsBShx+gzgMMH3v/OmoUPrUYVtYlwxTQg=
X-Gm-Gg: AYBFou2Jt40XU8AfmU92aJLYDv+8hnRpNFMesFSmlN3yjq06scTb28QTl1pMIQ/M+Sb
	vWEO8QpOf4ZbsTPdkon3+takPWwLuXni8iiNnnQgixW8CC2ZeK4xsMAZmbp3cGwg85BDztnnjG5
	3mUFH1fPX/wbpWf1ElVykt6QkiutiA+rpu6fKjURgcuvmmJwVDFQoSM1/WBFFSGhF8ZEBarxhO9
	dzHMSIOTT5KCtSCTEeteohdCtGMWtgBJyEy2lm4OOIgns9ST9zDF+38GJb77oqgTmGnMYSYJwIG
	nNLLH/E6OQueG3+U1JW6eviNTJDi3E6/Bso4GgKQ/SvWLNsh/Gs1hv505UDwhRKqlAnrrbzkWLX
	kQGR5+oybQNQgD7uvfR9P6rWhneADI6JjPvBWvrfXgiCe+g5vvuNX5Ud/wdMZ/XRq4wsQsZA9h1
	GLLkWaAlzEeFAIzK0tE9PshhQZFEm6VqvNZOiOPdlq1aBNfqjCKE3XE7o6czP/x2Z6nIZEK7IrJ
	NA3wwFqo9kBpHDff/K17/BQLWihZPsi8mWQ7Hn0xAn3t2ayY38kPPlO
X-Received: by 2002:a05:622a:1ba0:b0:530:b2e1:2f3b with SMTP id d75a77b69052e-5329b61d526mr11929121cf.50.1789662928648;
        Thu, 17 Sep 2026 09:35:28 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5326208ea78sm56756741cf.24.2026.09.17.09.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:35:27 -0700 (PDT)
Date: Thu, 17 Sep 2026 16:35:19 +0000
Message-ID: <c51591e0e96c837bcd762c207e5e1869.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Andy Lutomirski <luto@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines
In-Reply-To: <8fea176a-0ca0-4a70-8cf9-8240a22359e4@paulmck-laptop>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com> <aqlgxKGk_AEKls_1@localhost.localdomain> <edc7cca2-a5c5-455c-8969-ea05dbdb08f7@paulmck-laptop> <aqqONH8flTIpOUqT@localhost.localdomain> <91687748-0781-4133-baed-43cf82f35ff5@paulmck-laptop> <aqqpRoTfywUuTgoC@localhost.localdomain> <aqqsAUVV8a1yrQzX@localhost.localdomain> <6afb0afe-e7b8-46b4-9fea-2c7cf4791044@paulmck-laptop> <aqq0cwvRDsorGwgc@localhost.localdomain> <8b73e1b3-0580-4ba9-b2e0-6363e429808d@paulmck-laptop> <aqvZwfUVsiEI7q7y@localhost.localdomain> <8fea176a-0ca0-4a70-8cf9-8240a22359e4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 08:40:10 -0700, Paul E. McKenney wrote:
> On Thu, Sep 17, 2026 at 02:14:57PM +0200, Frederic Weisbecker wrote:
> > You're right. So we'll indeed need to reuse the deferred qs points here.
>
> Except this is getting a bit involved.
>
> Don't get me wrong, if Josef is happy to take this on, far be it from me
> to stand in his way.  But if not, we should be willing to treat this
> optimization as a follow-on effort, whether by Josef or someone else.

Follow-on works for me. For what it's worth 03/13 is already fairly
close to what Frederic describes, just outside the core flavor: no
task-list scan (the GP waits per CPU for a pass through __schedule() or
an EQS), the irq-exit preemption path checks the interrupted IP and
queues the task as a holdout before the switch, and the holdout is keyed
on where the task was interrupted so nothing is needed from the
trampoline tail. Moving that IP check into the tick / rcu_exp_handler() /
deferred-QS paths and reusing the blocked-tasks list is something I'm
happy to look at once this has settled.

v4 will pick up Alexei's ask (reader emitted by the BPF JIT around the
fentry and fexit regions rather than in the glue) and the idle-CPU hole
Sashiko found.

Thanks,

Josef
