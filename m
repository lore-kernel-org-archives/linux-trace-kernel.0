Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0AC266183;
	Thu, 13 Mar 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863903; cv=none; b=SeYzX0/BdDSpmjT8pzM6ldWi9OIP7YZbEEEEsJtBFBuxfRE++BwXNr3mNuAKNoXP0+0vMQ/vTL4ADZ0GwgoB4PXxKwAr3wnvWdApyW+yZBRzZauLy7ewk75diUrcO8iiOAi1a0lcOIG1N15gRpoZdrL9/ueLg3613BjoQS5nTjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863903; c=relaxed/simple;
	bh=LMCJFtaWFhDocxmK7YSZdLwpqnzpwliApoktuPoLZvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vi8ahLRedxfuuNRzyo82rxwv7ObElPzvFoiC5iwJA+p5PLMLw9ThFoVyXMW+hcWGF7AQg57SqsB7ZNUevrZUdjxKz2BMQgnNfdo5ujWh+jjV/8LxBn3CVtM6FhU8hPNEsGBv3OhvNzcXgVffkFibrxIdascBJbC05ZI+6El+2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C374C4CEDD;
	Thu, 13 Mar 2025 11:05:01 +0000 (UTC)
Date: Thu, 13 Mar 2025 07:04:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] docs: tracing: Reduce maxdepth in index
 documentation
Message-ID: <20250313070457.647c8c57@batman.local.home>
In-Reply-To: <Z9JKqVvG1iw0bFXR@archie.me>
References: <20250312124717.7208-1-purvayeshi550@gmail.com>
	<20250312134907.06d27d78@batman.local.home>
	<Z9JKqVvG1iw0bFXR@archie.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 10:02:01 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> If you'd like to generate a patch series, you can refer to thoughtbot
> blogpost at [1].

??

This is already a patch series.

> 
> And you can also add cover letter by passing --cover-letter to
> git-format-patch(1).

It's simple enough it doesn't need a cover letter.

-- Steve
