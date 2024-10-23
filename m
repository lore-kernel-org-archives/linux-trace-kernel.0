Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0DE5C603;
	Wed, 23 Oct 2024 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661450; cv=none; b=V+5DwncD0cOzDoBbSo9NHyX8+/4sy10LkQfWXj1YiEOHYdB0YhYtHogCO1KOkM2VWbf7ofqVZXegeQQC4fllLGxjjC+fBiPzfm9eiIOkH887d056cZOMP0+Hasl1tkUEghkylUWraEkN2vsWvFhtxF73Xv0JTppo0QUvqp/Ggwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661450; c=relaxed/simple;
	bh=XztFMoX171U1Xr+cvvaOfNpd5/0kwJ4ByixMiXTpzZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDOVZdfZLik2KbQHmg8m5tAX9CPdboFhfpfVqDMyZcXjM5dM76DfXZNkBM/lNW30uJIlsTX4PhsGrFXKQA9NiYoOmq6m/TxgOFV6vbn7jVfU5fq3blR7aS84tiLMYEZXA3R0ydRZ/nqN8N1ZODlxGhQv52Js0MNDChXz0si5VyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 81D7F227A87; Wed, 23 Oct 2024 07:30:45 +0200 (CEST)
Date: Wed, 23 Oct 2024 07:30:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dma-mapping: Trace more error paths
Message-ID: <20241023053045.GA1648@lst.de>
References: <20241018150036.2878190-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018150036.2878190-1-sean.anderson@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Sean,

the patches looks fine to me.  I'll wait a bit for more feedback but
plan to pick them up for Linux 6.13.

