Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD983BF672
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Oct 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303060; cv=pass; b=QY4Y42x6Rldna3Io2+RByYuKhQS2kH9hRi7N/MmsXc6+kNniISH+D2eQMW+vC2eXlTky0BqO0onbOO77s1K0tzEapVOolQy8TG8xcVr9M1r9Um5vl8bpXEOVtN8QWpGpNtzam6aGZlx+Xas9odVabu8IC52fXyZOIWtwLKYlmcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303060; c=relaxed/simple;
	bh=9WCkiE19cbtAuYYQ4uqsh1anpnBBbEDR9fWCfux10TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7jV5safuqhbJQt94HMjv79riPOZcZea+Kao/o0EvzmBEsO0tKv7AihF7x0lMLDHc5K3JG0zrb8Yy98I6dxa6Cbod38Gy7+WuOaiyUTCbEtmEj62+Cqw2qiwi1D0Je8U5LiLeINEvpO5BG4RK2QOJoN+foWSGs3UjdPKQosScEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JwSdedkv; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwSdedkv"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ab38a051aaso8455377b3.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 09:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791303055; cv=none;
        d=google.com; s=arc-20260327;
        b=n0i7/U0Me+0uZ7maeKLuTjNnnriZk6e47AgA3w8Ulu8XNLA4pP1Z2hrP4TmZT42Ndf
         XbJgPBVfBoJxOtnejCy4zIYtQh8XpyPat/RU/x/KHCxP3t7duw8WlI+8TWa4vf4xrX4h
         6Cv8bkyGjIKpmSjqA7D0Ni9wEjOjgS0Fj0j60vYBYuNN6lhHbPZAXhBn/xIw2apO9Zz/
         VybqBVk1bOwKqVUsgYA0EV1WRiky129QlL/cC6RUw+cDwimWrd2tOwJujuU3xwMGvlgm
         z1a5iJU+uzjsis8sEe63XAbHhZo4wLFdH5M/PhhTTTXvPtUrian6XYtctuZqTPf6XQ6U
         nUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bfR6JmlAO4hB3DVN/nKPNuuxv4ZNwhQvNLDvwEb4/Vk=;
        fh=5u2ExpPvy1QSoawb/0I9qNYZf4P0xkgshbD4BEzi7b8=;
        b=CRrmS60OWQNCP/YDzLCAL+P+mt6ZNQzQZkOlA29uidIKiUjUwWTfUN8Bl4hHV37wgc
         PJtkXP0uKvObE3OlnN+mfInbsA9v9bkyZKr9jfKWMKFWhoQaphlT+zz2zSJQjgIl+aZz
         og4dDusgL5/zOR1B+zK76G72qaUe81igfzMNX2vIIRO27+WUCWK4tmHqpvfyTvsiqnEO
         vLo25qE/yYPiAIxG9nvgMHa4ZMyA3Y+19wVkfrbuwdqVX6jqMAj4tfWOJjvqeWgedhDb
         Klk6ax8bwEs0KsRzZ9kHeF6pNyjc7JYYV3uBM7klqXYBqvFKvgjOP6wA+ZE/TQ2t1HHY
         ArSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791303055; x=1791907855; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfR6JmlAO4hB3DVN/nKPNuuxv4ZNwhQvNLDvwEb4/Vk=;
        b=JwSdedkvU4HWA2M3bRiTIb4yUJH/G/6j3Ze5FMckN/eew0613vcp0JMe9kvOi+DOuY
         2VJzaCNXVbhmEMLFz6cFCs7h7oitGNfA1aSwqYbeW7pgZpODcmm0Jue+hr9b2oDm501n
         YFu/7v3ZjFC5B4mBHIUBBRvViLNLpd6QNdEef7TYKwxV0YbvxDYboiaxERYPGWzfY4CL
         /bA1BJCQJgff4ojK+kBk71U266MY/VHGjuUp8u1J7YoxOxdFwqOe5njzUpnvGHfyG35H
         9xkdDE92TRGS6KGLsGVlfHDLoihWR7Qnz2PsOnlAFbDHYbmAOrkjhjhaMVdWZxHO+wcv
         Emow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303055; x=1791907855;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bfR6JmlAO4hB3DVN/nKPNuuxv4ZNwhQvNLDvwEb4/Vk=;
        b=LRMHk6c/DSVuxSlG0TysnSFK3jk2H15wRpcTheLi9A/von2a/Y+hdPiZa1SOBYT9po
         3yis71FeqqrSe6pwMSowzaSXkRhfxYhbnA0Oj80KluZsj00AQ1JykpzP7i6dfrBFanmV
         NFVfLlrQJ/JMqVv40xhjQKAQDrJS/6dTv4Yncksff9q9+6mMLDAn91vHcR71jYAnWYRO
         WGNmeqCsnOQtITLQQvSD9UhsBR/ENzt5ffV348b45SS0j9j81dt3e54m8VQYabpPtfy7
         Xo/H2+109fWTVklKUkNnpzB7123S7pTgkehgxz8/nzZrh2aTGRixilOY9pWiNL+Ww9ZC
         HocQ==
X-Forwarded-Encrypted: i=1; AKwUvBwha10+aNu2YDsfzf/1ZuvGh4/56CsIp4z3/iTfcx7a7zGIObnOtTBRnkCC2j77E+iD1OmYW0UdBJ4muRqUDGkr+Ls=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPM13rQyndCXTXJfvBwsgMEiXdVQMGPBQB+phFGmM3gbS8VjM2
	5OLLYR4meyds2XaTDdIBMno+Kb56xkdxxHbMf+U3PFfmeHqyg9gyENejh9ajyto728RT7mi+ce4
	XxqWtrOOZVB/OgnkFCWiaS5FBbvJjCQjCwDr+Eypj
X-Gm-Gg: AYBFou2g8XG6uLgU+U+hSbp0/+Qu8/PB33q4iVsvXPweabHgTYOn/Jvr2GUCUVEJxnU
	I0DxeOb/4mY2cxyfNQHLP8Jpjkv+Sb86FygrqYmz81JScsPPrFUJO7Tcy5cAizo9Fu9dSlo8/IN
	oh+M+UiFe/vtR0KG+c68UQIfaa+4kUTz2vDjgX4TRB7dqOdGaL51anUM4mVCNcWa/cF4mspgLOF
	N6kyARgUUD0utyZzAy6rZ4QbJurkYL+n14DCPnGT46Fj8yYV4iLy1KHZri4ufFR1cVrj4H3N12F
	LyIWYROZGvst7dJOFnyySpmeO+1dI22iQk4N2oMW7KlQ9JLmBaxk7Q==
X-Received: by 2002:a05:690c:5302:b0:8a8:7e5a:dc2f with SMTP id
 00721157ae682-8b04f40f097mr9171807b3.12.1791303054779; Tue, 06 Oct 2026
 09:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00ed0b57-ad05-4c5d-b152-7c81df94b23a@app.fastmail.com>
In-Reply-To: <00ed0b57-ad05-4c5d-b152-7c81df94b23a@app.fastmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 6 Oct 2026 18:10:17 +0200
X-Gm-Features: AclHuK_OeB6Z7-eCIUVq_1RabrgIKOGeEVPLb2q2UdMqE46rpsfhYWgMuA5UU2w
Message-ID: <CANpmjNOaykC4McAj=gZghqPSQc9aGBP_CjgKmp3n2yjeJTxDSA@mail.gmail.com>
Subject: Re: [PROPOSAL] Replace gcov and kcov with llvm-cov
To: chuck@wolber.net
Cc: kasan-dev@googlegroups.com, nathan@kernel.org, akpm@linux-foundation.org, 
	anton.ivanov@cambridgegreys.com, oberpar@linux.ibm.com, ardb@kernel.org, 
	arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu, 
	johannes@sipsolutions.net, jpoimboe@kernel.org, justinstitt@google.com, 
	kees@kernel.org, kent.overstreet@linux.dev, linux-arch@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, luto@kernel.org, 
	marinov@illinois.edu, masahiroy@kernel.org, maskray@google.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mingo@redhat.com, 
	morbo@google.com, ndesaulniers@google.com, paulmck@kernel.org, richard@nod.at, 
	rostedt@goodmis.org, samitolvanen@google.com, tglx@linutronix.de, 
	tingxur@illinois.edu, tyxu@illinois.edu, wentaoz5@illinois.edu, 
	x86@kernel.org, peterz@infradead.org, sashal@kernel.org, 
	Aleksandr Nogikh <nogikh@google.com>, Taras Madan <tarasmadan@google.com>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 17:14, Chuck Wolber <chuck@wolber.net> wrote:
>
> Stemming from some hallway track conversations with maintainers at LPC
> 2026, I propose replacing gcov and kcov in the kernel with llvm-cov.

I know the origin of the discussion, and wanted to chat, but I guess
that didn't happen and instead we get this proposal. It would have
been good to understand the requirements of users of gcov and kcov
(more below).

> llvm-cov instruments at the AST which enables precise mapping back to
> source code regardless of optimization level.
>
> We have a set of patches [1] that implements kernel based llvm-cov. They
> need to be updated and some additional patches are required to address
> some stubs that are missing noinstr annotation. But otherwise I should
> be able to send a full set of patches (including taking on the
> maintainer role) to remove gcov and kcov and replace it with llvm-cov in
> fairly short order.

The hallway chat was supposed to figure out if there's a way to bridge
some of the gaps, but jumping the gun like this without having
addressed the requirements of kcov users does not make any sense at
all.  As for gcov, llvm-cov was designed as a better replacement for
gcov, so that makes more sense.

Ok, well you made me untangle the most important differences between
kcov vs. gcov/llvm-cov below so we have it for the record.

> If there is a desire to take this in pieces or implement other
> intermediate steps, let me know. Otherwise I can generate a monolithic
> set all at once.
>
> [1] https://lore.kernel.org/lkml/20240905043245.1389509-1-wentaoz5@illinois.edu/

llvm-cov is generally useful to have; llvm-cov is closest to gcov, so
that might make sense to replace.

KCOV, however, cannot be replaced by llvm-cov. KCOV isn't a coverage
reporting tool for users, it's a low-overhead interface for fuzzers
(syzkaller/syzbot and many others). llvm-cov has no equivalent of:

- per-task and remote (kthread/softirq/USB/vhost) coverage collection
(to avoid polluting coverage with concurrent tasks);
llvm-cov counters are global and polluted by everything else running;

- ordered PC traces (edge signal) and comparison operands (TRACE_CMP);

- performance: a per-task mmap'd buffer reset with one store, vs.
reading/resetting
megabytes of global counters after every program;

- GCC support (we may want to keep at least one GCC-supported coverage tool).

It's also UAPI (include/uapi/linux/kcov.h), with existing users.
syzkaller heavily relies on KCOV's features above to achieve good
performance and coverage; there's no reasonable way today to migrate
to anything else.

As-is, NAK on removing KCOV. Consider replacing gcov with it.

Thanks,
-- Marco
