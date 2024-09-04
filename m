Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BEF17C64;
	Wed,  4 Sep 2024 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725423328; cv=none; b=sDxO5Eb7IyEFwH6SLIqMBVmHvrLCehIuMOefJZ/F/vzUnhqNiDSuURgSSlpl+4rKfFa7TBdnFMfn5vrofVg2q/zKPx9sX08VjA+sHlootAnGAx2yr0BCjzVTzKtDFmoXSVZX5I+TS39jLU0FKrK2CxOipzv3HShw6/YlJFnLLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725423328; c=relaxed/simple;
	bh=J2aRFA2pMhcoLz++9eY15O2uQJaPDBQeqT83I3XGURc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeLi4w4XdXG6H9rGnHC/Ii6W/h20HIIEZWbra3lDmLRfRSg08e/+GE6a3QCge8Zr1gjy1qFAE4259+QQg/7EmZK69k9ZCMZRSH1IBCCkKhYOk+BE8B5bpGVZzHIvxAa/F+TbAZNaDpkRYxmvbe17MrEdgo8kUSQk/tKUIu2cJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C25DA68AA6; Wed,  4 Sep 2024 06:15:22 +0200 (CEST)
Date: Wed, 4 Sep 2024 06:15:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dma: Trace API
Message-ID: <20240904041522.GA13349@lst.de>
References: <20240826203240.2234615-1-sean.anderson@linux.dev> <20240829041912.GB4408@lst.de> <4c2c6b24-aee1-495f-ab47-662e1e818f4b@linux.dev> <20240903072512.GA1521@lst.de> <20240903092154.5f0bfafe@gandalf.local.home> <d8936bfc-1ea3-4142-8035-0dfb8e491c31@linux.dev> <20240903205322.69d7638c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903205322.69d7638c@gandalf.local.home>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 03, 2024 at 08:53:22PM -0400, Steven Rostedt wrote:
> This should do. I could get it into the next minor version.

Sean, is that enough for your use case?  Otherwise I'd keep the
unsigned long long for the _sg array, and use the proper types
elsewhere.
