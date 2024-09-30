Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4E170A0C;
	Mon, 30 Sep 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683850; cv=none; b=rY6Qt5N9WLIJNKXMcgmwLkDZQ2+MXQKgPQi+kkcsVaeSEYgt4Y12lL7MpiM1NC5d+k21OlwWbBBVLWYYxIGYShTASV3eHbiguS8qsMF96yU7ce5VuTxiPK77Ubi0SPFcrepfP2VrqhcdOPoe7cE5902pvDg5AFeS0/deJALBry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683850; c=relaxed/simple;
	bh=oiDcd/wNiRfLwXZXyPl9c+VFLajnuiu5rEuv9o8m8Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKZmh//ywkt5ML/SBiM/hZs4PwFTztj08jcRtw6ZOctSQ4T3NVbe0KyMc4ZqbbWeARRtcUOzSHs0bLSUQC0bFZvHDkOIwdHf46SB4x61suvWL8YsYGAVVrvsaJdQwps3Oh9rYbUEorVe1IXiMGlXdhrBBL/4EfUoG/uaFpwqkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oEURNLe8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEURNLe8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KN2bQmh1Ub7bYfP4ogErao3ah0jN5MIfnfdl9UbY7oY=; b=oEURNLe8+ELtzlhN4VGqSX26VK
	6GTZXHHv+5Spodc72pTuTmwVRrygRCju+LLbLFc63q40ywTSldpGHrSY0A9eYihZuovB0VwTnzcM4
	pJhx9sXEiQ5Bvoe8l3MFxrxWNP5zkCu/mrgQS92B10w3q9MnD61Olj9fxXLMFgtttILaO5jH3TGz2
	fPrMqWTsihHEunYK+lgq/rQGycsbncmnyMws6cLh88UQ+bC6WrEM2CfawEIr8K0amefVzG9z/eMXa
	KrAFY0vinot1F0uqEQ21/jOy6U2WO/mOSt7snyVI69SB3voK8EwJ6Jyvi753sxPGzUPiJpQiiUW7A
	i/zTu+iA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svBUT-00000002mKU-1LjT;
	Mon, 30 Sep 2024 08:10:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8BCD3300754; Mon, 30 Sep 2024 10:10:44 +0200 (CEST)
Date: Mon, 30 Sep 2024 10:10:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] uprobes: deuglify
 xol_get_insn_slot/xol_free_insn_slot paths
Message-ID: <20240930081044.GD5594@noisy.programming.kicks-ass.net>
References: <20240929144201.GA9429@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929144201.GA9429@redhat.com>

On Sun, Sep 29, 2024 at 04:42:01PM +0200, Oleg Nesterov wrote:
> Hello,
> 
> No functional changes, please review.
> 
> I'd like to push these cleanups first, then I'll send some optimizations
> on top of this series.

They look okay to me, I'll queue them up. Thanks!
