Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC82D23A5;
	Thu,  4 Sep 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976290; cv=none; b=mmM4/9mlwx5VPV+XtC1dyt77A5+IAzeGkF3+gxDITKDVWFrHZKORO4lB6QphwTghdDYMENcEI4aMrJTtQPqR6cA4AELptx/O3vbUbyNfAJRlo2+pR7zD9GGujwIjsTGmd9W8rpmoAWgziTMW5wV0y6QZg6mEzXX9DrxLyTfpj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976290; c=relaxed/simple;
	bh=t6L8ZlnVN36wvOF7lHp++9Zn1qSba4PbffbnNTtGYlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx4NgfU04VGFMuaDRcuNIbAi7Yv9BUFa7QubJJvdfxSwYvcu+6ozdFNWWZn7RTaFhVhaC8n0WDpbe6EGtG02idnVTTYUS83nCQV0SSqKtteluf8wA6eEft/iXYVd71NZkbYRy10b69C7MuIC+jPedS2jxFv7eaK/gUkekOqspFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3E110RiW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vNClmjGW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3E110RiW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vNClmjGW"
Date: Thu, 4 Sep 2025 10:58:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756976287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHWraxP+ssEoLc7VJUdtZWdkuJMer6cVKoa1HpNeYug=;
	b=3E110RiWS0C5ryrnh3OGKC9EyVceoxOsVcCOMf1YuxOIVALliajwDLOZjuzFbTfgaWlcLu
	kiNytkNSBbi32VcAePskuWDBDodgRQrldFj4Tu03TOnorSDpMRbxe8trjszsDqtyWT/AF9
	HSv5yLMnVDlmXiCVbDySC8TLw/8zPvIiKEdRkg325rq0g7M5rtFsrDaxj0cbnIouf77qCE
	so/3Ht1fwXKvLWOh2IkY+V27k7AbzJ9251eyOndrr7v12ZvaODpMJrYHljduN3r2Jq4BUy
	3x0ZedMvsCE1B0fwaPCwh5/RXLR5Q0Xwo3GX1xaylda18PKvyrhTRkpO4Zh/BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756976287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHWraxP+ssEoLc7VJUdtZWdkuJMer6cVKoa1HpNeYug=;
	b=vNClmjGWAjc9K0tDAof+6W5q0ZtGexcpfHGXsn+OOjt18AaoF9hVCsnvOx/6LReszPAD46
	uSWV813wFh9T3SCA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 16/17] verification/rvgen: Add support for per-obj
 monitors
Message-ID: <20250904085805.X1LXKplC@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-17-gmonaco@redhat.com>
 <20250904082054.W0fQJAQw@linutronix.de>
 <a2813fab9089cf89d6ac60998abe4fa3f226d9d7.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2813fab9089cf89d6ac60998abe4fa3f226d9d7.camel@redhat.com>

On Thu, Sep 04, 2025 at 10:39:31AM +0200, Gabriele Monaco wrote:
> Mmh, I see what you mean.
> I wasn't aware of this textwrap, but what immediately comes to mind is
> that we'd end up mixing spaces (python indentation) and tabs (C
> indentation).
>
> While textwrap may handle the case, it doesn't look too readable to me.
> 
> I'd say we can (slowly) transition to using textwrap here but mandate
> having \t for tabs to make them explicit (didn't test).
> 
> What do you think?

Right, I didn't consider the mixing indentation problem.

Using \t isn't much better, it is harder to see how the generated code will
look.

One idea is using something like clang-format
(Documentation/dev-tools/clang-format.rst). It doesn't have to be done in
this series of course, I'm fine leaving this be for now.

Nam
