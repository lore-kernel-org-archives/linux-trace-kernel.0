Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F83E95A4;
	Thu,  9 Jul 2026 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584897; cv=none; b=dfpAKzrp5iOYjC7qsE0GTwHIIFpEw1+SALoUk2QinplRt7sh28HTyld0MFKI3CKdOXPDqbgHTzQ4JJ/OumdsEp6XYqaR4hHlzF5BOmLfa10/XJb6RNnOYBN2H3IKDhR3AhrZxxFYOnCVJIqz8K/Jy9JHJS86nerJdMZyiEn+k4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584897; c=relaxed/simple;
	bh=FAGA+j61im64RLSykDcmN0ZwZKS4/jhCPMjPoavb1SU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qKKdlh23nosnO+IeYNhLNOWFf3E2HDLBAKupn2MDVwLR/purXQwg4LVa/eMCBNWiaJNVWEqsqL5OCtqpmkoM/kMDM4sPYAT2ryGCevQjvK5Woa+4CQaK/sTsRGrx23kUzm6AuqVQNo+MgnH47aRZ+c1IVBKG0IcsbvjXAgj6JEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJ3wZ07S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=chFC/8Ie; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJ3wZ07S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="chFC/8Ie"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783584890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dgXuarY0tjG2ZnVnz8R+iaDHPH7H2Yx2Xk1CEMAsjbY=;
	b=RJ3wZ07S/MXfpiXeqVie4MP/XaiuxkNEBt0iv53gRYwn49tXuby2MIX+sZIr1UGpg2lNuJ
	B2BI3KwKechjQUk+FFGurJGOeFpGY4EpJIZSGWmtgoxxLvyDTzs+SeO7QrpBjvVxmJFW5z
	1NKTAnKK4ZxzMCCah3JQN8enZA1paVM6SO2BXbck1kea0fKDTz7etmfCOGB74LKIgGxoFp
	hSRuxkII7IEou7+Sox0Lb7Aiu369YQVMrJl9fQ3wffg5dnc1yng+y40HnA9gAuerEeFZQj
	gy8CbvWHKM25wBh6cT2KoaxFb/2kdkfjx/Y3XoAjfe4hwyrlCKN0Zq+4maCOSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783584890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dgXuarY0tjG2ZnVnz8R+iaDHPH7H2Yx2Xk1CEMAsjbY=;
	b=chFC/8IeAkLSAjjDiDFuto4p/VQJ1wvhtYHlQW1ksKyAYFRGAMOZf8P/w0EqWkDyHpEcOm
	tiIzyddspGX/BvBA==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Shuah
 Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 15/17] selftests/verification: Fix wrong errexit
 assumption
In-Reply-To: <20260625121440.116317-16-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-16-gmonaco@redhat.com>
Date: Thu, 09 Jul 2026 10:14:49 +0200
Message-ID: <877bn4fukm.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> RV selftest rely on bash errexit (set -e) to terminate with error, when
> a step is expected to return false, the following syntax is used:
>
>   ! cmd
>
> This however prevents the test from exiting when cmd is false (desired)
> but doesn't exit if cmd is true, since commands prefixed with ! are
> explicitly excluded from errexit.
>
> Use the syntax
>
>   ! cmd || false
>
> Which ends up checking the exit value of ! cmd and supplies a false
> command for errexit to evaluate.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Sounds reasonable.

Acked-by: Nam Cao <namcao@linutronix.de>
