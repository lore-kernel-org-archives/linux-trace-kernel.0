Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F81238D3B;
	Tue, 18 Feb 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891333; cv=none; b=sP/z2IQDKQOXFnSEHPoZ2Ib0P6uiQd00JwHolPKT6pUnnXPZ0I/N1+TUAf0h2xkbbG7Z/ffORApxqVlilBL06glqwpg7JASK7n4ad9TYqf6lPlp3nXN9CcEjy4nOO64r6d7Kui9mKBK+g1pnz7MD7MedWCRq8XBbdUf9rj5sN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891333; c=relaxed/simple;
	bh=C2H5wAjc2KrxGji61Y/Dl8GqE/wcFsvQccted8JJdpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQV6lLVPp9m4jwjilUW3bDTOJ8oAtfj2o688i6GizJMfVgLNyL2XUEG8XThP/yR/HfeMNNsfpyWcFa5DQqpacuJP29xQ/0FAksY4x/TuMP0D/I8iHb4pUwqRTFLKiPHb4k8VwwoQ+SaI/6VC28bvY+/uu8+8krRKgx4HtyuzK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5eiRnq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5eiRnq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50332C4CEE2;
	Tue, 18 Feb 2025 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891332;
	bh=C2H5wAjc2KrxGji61Y/Dl8GqE/wcFsvQccted8JJdpk=;
	h=From:To:Cc:Subject:Date:From;
	b=g5eiRnq70gth7G42fuezAWCEnXoutX/8Glvvqyh+8YLrVwwsPXq0MKfDFNiIfrJmZ
	 zePLiOvckZjkcrpNO8f4EGITZZazWhxarrbi+2ilvRK5rB9/hDYdFUSRuAduoXv/vP
	 8IIvmwjzUfLFQhLUvf+jpm3GfoEKiF8Y9Gf5UyRTzMVLvBRBJgHKzhqvVQF9w0Wj/3
	 s8HP0hqMmJ3U2zlLFjbbDHhK/06nMTnNfzSm0LzKRYvWi9NF6QCHj3SAuOuabUSiFa
	 NVLDTiOMwZ4E0ywkBJdVIIFQj2EZLnl8VBPvClIgBIQKTTMRcbeHOA9CsOhVzLKlub
	 l3FrryGpOKwTQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org
Subject: [PATCH v4 0/2] tracing: Make persistent ring buffer freeable
Date: Wed, 19 Feb 2025 00:08:47 +0900
Message-ID: <173989132750.230693.15749600013776132201.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 4th version of patches for making the persistent ring buffer
freeable. The previous version is here;

https://lore.kernel.org/all/173928521419.906035.17750338150436695675.stgit@devnote2/

In this version, I used free_reserved_area() instead of custom releasing
code. This seems working correctly. Thanks Mike!


Thank you,
---

Masami Hiramatsu (Google) (2):
      mm/memblock: Add reserved memory release function
      tracing: Freeable reserved ring buffer


 include/linux/mm.h   |    1 +
 kernel/trace/trace.c |   13 +++++++++-
 kernel/trace/trace.h |    1 +
 mm/memblock.c        |   66 +++++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 68 insertions(+), 13 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
