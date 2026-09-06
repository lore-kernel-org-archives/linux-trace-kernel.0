Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB24355F4E
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715084; cv=none; b=O/GEJmlBJCkkQ8qNYxky2IhVqEU/+X7pWjIzEHP2tQyAnff0SPQgde3Ua/ofFJAGOfZoPOKnagnWYLQEI65Cwss5XYuyMF01fcyUF8P/7hFmwew46oTvN6fWOvIsVwUn/H2LnsQVFRY3ksIE2EVzW1uYx/Pmd4Z+Dx7ODIZMxAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715084; c=relaxed/simple;
	bh=09cPztP2A0AC590v0KlXU4819aEDWCV1pznBiQhBcWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C9lYlqKD9Tzkwx3CkzlVMsRxjDohuiDzDLWOAFGFcDtypsdox1apjfASgABEsNfCff1iXWXw74qgVOZa43a/NuWpigoJxW3VulEbSD6fpliqNR/1gKsv32YpAAdfXaVpBtRQ+eWdSLj1kltkxubnVlm73EGzjz6EsQHGWsjP9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owT5cbTB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owT5cbTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50EE1F00A3D;
	Sun,  6 Sep 2026 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715082;
	bh=09cPztP2A0AC590v0KlXU4819aEDWCV1pznBiQhBcWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owT5cbTBeJgBrp9A/eYJ3Xheb12l1hZ4E9TPaQs1yq/WRFR2zk4awUYUrv7c7jDAt
	 5WUugF7AvMdtXrJm5pVbXqrL2MckMdr2KbOrsqZfKIs72uzZZDO2r1P4xKMKxys6kR
	 Io9l9UD1h1Uigl1ULKkbvjnK8l4zPMefSYRXREO/yz+i9d6wpMdJHH8PE2O07oLzcP
	 bFLbo0wOU8g+5BXL2JqcdZEs1pyVaoFiVtZpJ9MO+Sr3gF0j6ZY9xMBKhglpGRA+1+
	 bQEA3hBOoAHKx3P2HRpNxNnjHlK+56JADubfVmDGIEiZI6rY/HGj6wl2YAeSAoWJfC
	 2+UY7chtagRdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] rv/reactors: use LD_WAIT_SPIN as the reactor
 lockdep wait type
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <a43e36b73cad69d7e9f26f234b97733c8e74e495.1788705281.git.wen.yang@linux.dev>
References: <cover.1788705281.git.wen.yang@linux.dev>
 <a43e36b73cad69d7e9f26f234b97733c8e74e495.1788705281.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 17:18:02 +0000
Message-Id: <20260906171802.A50EE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message claims to add documentation, but the patch does =
not modify any documentation files.
--

commit 9f88f295cb2517cf173e24803d40575bacb352d6
Author: Wen Yang <wen.yang@linux.dev>

rv/reactors: use LD_WAIT_SPIN as the reactor lockdep wait type

This patch changes the reactor lockdep wait type override from LD_WAIT_FREE
to LD_WAIT_SPIN to prevent false-positive "Invalid wait context" warnings.
This resolves issues when preempting code, like the scheduler, takes spinlo=
cks
while a reactor callback is running.

> Use LD_WAIT_SPIN instead of LD_WAIT_FREE, which causes false-positive
> warnings in preemptible contexts due to scheduler preemption taking
> rq->__lock. Add documentation to runtime-verification.rst.

[Severity: Low]
The commit message explicitly claims to add documentation to
runtime-verification.rst to describe the LD_WAIT_SPIN logic change made in
rv_react() (kernel/trace/rv/rv_reactors.c).=20

However, looking at the patch, no documentation files are actually modified.

Was the documentation update for this change accidentally dropped from the
commit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788705281.gi=
t.wen.yang@linux.dev?part=3D1
