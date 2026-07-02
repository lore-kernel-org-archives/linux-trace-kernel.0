Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD8264A9D;
	Thu,  2 Jul 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000419; cv=none; b=Jtp1+ShWLiu5tkRONW9sKS08/u4RJ6LlvYEk0/rHWR6RHC4eQKlMEkyfZENjqOCMem3/lvYVmRbC2KmFDfl57I6/1O5NIM2VBiEnh3wQD3l8vB36C7vGSMTJzhrL0DcsM43KYi+Oxoeix9o+uSOUBlPoss1kB5UuBh2txihDN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000419; c=relaxed/simple;
	bh=UvV/6sETUNs0YefuaI7yvMnJiH0PBi4VVhtF1BJahxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lGJWSB6/IaQ55K+Jk5h6gUEYobz+dckMO7kQ7GZLw0baztyvGAcmFdmR9/Ho1HQw6xz+cjeTL431mviYxp7YpEbg/bhzmJ8IQQ/GnBaTgjagoraZ8kbIERjq3au9QiQGWj6quWJnJXW+eD/QsAtKNmEHdbVaj46cgyjXxumGanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HCYmooLB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZbWTCyCa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HCYmooLB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZbWTCyCa"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783000416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/dPx8xkCEYlKDbOwNJa2cm8mXRIOsHtkfvMXANTQIMI=;
	b=HCYmooLBj0lS07JK9R0S8b5xEbkhSqb/W31dHwNiOqMPfIqpRTpWYyBsh3XHGh9NTBLLbN
	86lCrCBugWTBWpw0SvxM8+u6/gGl1l474Bzw6PQBNyrCJQaIs6WzCNabJlgqeU9C95tYdI
	CybNhC2dKszOwmHzM0bLAMEqPdri4aKMRB7YoBIiCERGLRPVsbOHNrq4LGE9dORIFKj/CE
	IbVJZYoOXublcRIm3wyXwazOQNrZs8wm9QNJWJpZTjYDc3s6XTVBOdlsR3bNmFwwdPWIm9
	zBnUgxM6E3HiX1ctVwJU9wj7AkDCiiYutk34BZyEZ6EfJ7EToHM4qWnK8cVAzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783000416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/dPx8xkCEYlKDbOwNJa2cm8mXRIOsHtkfvMXANTQIMI=;
	b=ZbWTCyCarBkLFw6NIe3USbJERT6heVRfiACeLBm4gbTDleuYXyaunKoCdPxM80MMv0OnqH
	025CbmsdJtGUhtDw==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 03/17] verification/rvgen: Improve rv_dir discovery
 in RVGenerator
In-Reply-To: <20260625121440.116317-4-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-4-gmonaco@redhat.com>
Date: Thu, 02 Jul 2026 15:53:35 +0200
Message-ID: <87y0ftijkw.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The RVGenerator class can find the RV directory (kernel/trace/rv) in the
> kernel tree to do some auto patching. This works by assuming PWD is
> either the kernel tree or tools/verification, which isn't always the
> case (e.g. when running from selftests).
>
> Make discovery more robust by relying on the absolute path of the
> current script and traversing backwards the right number of times.
> This should work from any location if rvgen is in the kernel tree.

Agree.

> +        # find the kernel tree root relative to this file's location
> +        current_dir = os.path.dirname(os.path.abspath(__file__))
> +        kernel_root = os.path.abspath(os.path.join(current_dir, "../../../.."))


The  "../../../.." makes me sad.

We can find the git project root instead. For example:

def getGitRoot():
    return subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')

(stolen from https://stackoverflow.com/questions/22081209/find-the-root-of-the-git-repository-where-the-file-lives)

But that's not important, up to you.

Nam
