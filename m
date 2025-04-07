Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F852222B5;
	Mon,  7 Apr 2025 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007658; cv=none; b=VFflrvO8zXHz9IvuiBsTygBq4hruK+Q0A01JWuDMOcOVtAysxjlN9nGXEKVV0xzzXSo0NMd3wKwyBXbopAr7xnoaOpGX8tNDBv1Q2VhEGgSrH3BAVrHTp/5S5J6Vu9sVRBdnrIP+21yW2uv3u14R6k685tvfCd6nFZafkIWOweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007658; c=relaxed/simple;
	bh=F11fDBMw5qn285+fkZeSc1pLnkzv4B4whfL04ih4law=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mitXCTLK5qYwgjjhG/KIskD5uF0kd0A5EkMt3dnbEsTJpnCRp0uLck1dVceUarilZg1p9MVDMbRnBO3MFcSdoBUqGB+YcIelmGAaYdpaOY/sE6xNqfZbAsX3U+owJbP6R747CeZvnrlr8gVC9+lOlahiSLxm+kEM50GEfheUE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeuRe9kG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeuRe9kG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BFFC4CEE8;
	Mon,  7 Apr 2025 06:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744007655;
	bh=F11fDBMw5qn285+fkZeSc1pLnkzv4B4whfL04ih4law=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jeuRe9kGufU8+PPrx5sEagn1j8hzekfVNP81vaDE2sgMGlgwvJUXpUGfcc+Gff75e
	 pTKkZHpHSt5n9W3uTwBc1hCQ3e+OxWCD6yOaN7Co7LoSI/3CQnma1BuKj9q6D8WGGJ
	 bRGL6mKzaWt1XZYXPATPqJcgOJhk7P306wWAbot8McAvMjWm1REkGQ0y15o6k2JnZm
	 fzU+xw6RVmsaGZsfF3loVDiE+6v2h5z/e2WGA6M3p4wkzK3MOda8PfS1a3ee6AUgke
	 w0SBOaZkqP58qfZv0DU1IliOCtV2M8bmCdV3e4waiMqs7COraMz2ZNz4mj4VX/7HbT
	 izZ87Xo0pmsSA==
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH] memblock tests: Fix mutex related build error
Date: Mon,  7 Apr 2025 09:34:05 +0300
Message-ID: <174400747484.63432.18336494235808087526.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174399023133.47537.7375975856054461445.stgit@devnote2>
References: <174399023133.47537.7375975856054461445.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 07 Apr 2025 10:43:51 +0900, Masami Hiramatsu (Google) wrote:
> Fix mutex and free_reserved_area() related build errors which have
> been introduced by commit 74e2498ccf7b ("mm/memblock: Add reserved
> memory release function").
> 
> 

Applied to fixes branch of memblock.git tree, thanks!

[1/1] memblock tests: Fix mutex related build error
      commit: ed471e1984939a500eea179bc16e1c2aadf00db5

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: fixes

--
Sincerely yours,
Mike.

