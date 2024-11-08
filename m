Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98A47F69;
	Fri,  8 Nov 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064002; cv=none; b=F45h9JFODHI3/WKPozvZRdwDE54e2ykj/8BtdDCv69Bc68wI66tktw1VvFN+n9nrBuwMjFkpsgYKj1YdgrhoI06cVRbEHfJlOe8f//6g/X33/jdX725wM5UZLTuIslBRLy1LPpkEbSUSNbCCW1qt2aWgKxJv6kBLqIiqnQbEvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064002; c=relaxed/simple;
	bh=dXaG98lanFee9CnyrJvud7M2t9VwUcMVMib88PxUrKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvDPJYs3oB6GCtHQ5QiY0Mb7xEo2QKncOsYlCxqojnQcYvaQFO49hHUhf6pbugm3rKJ4flmzUMCFI85BV+HpcWIXvbQlwfcJtCb9GtOFFttondpOTWr/XHYfkXnQG5ssLEv6Kxr2xJEBloZKBIS2nUtHe5NHvGcsZEqcHBYJj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=K2Lmiucy; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="K2Lmiucy"
Received: by lichtman.org (Postfix, from userid 1000)
	id 792C7176E4B; Fri,  8 Nov 2024 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731063999; bh=dXaG98lanFee9CnyrJvud7M2t9VwUcMVMib88PxUrKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2LmiucyDnVgdTk1z3HmmXag2ZhApc0ZIxqwEF73RQlnqjobTlN+R1H5iNHJrx6b3
	 wnBIOn5I6VecYN+WZbkW7QII5dk9B6zgpT7/X3P/aRSYQ1Wmi+JQacql8Q8P/NY+Br
	 N0sJHOxVT70ZbBo2If9rdsp/664VQ+0emTZRZyZIrCNH9Nx/plFnI5YSeqOKsumLcl
	 N5KE5cBXybQcmy/2zoai18KO0oJnaFFJhR86sdqjihSymjbjt4HZ+Tp1/vv7Ur6ion
	 GVUAiZI2QOqu/Un8pzoQykIIkM0kj7bqnREcAA881c2mp2Wn0c323G7sQjLJZ3LYe0
	 7/9E+xZi3VeJQ==
Date: Fri, 8 Nov 2024 11:06:39 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org, yuran.pereira@hotmail.com,
	jason.wessel@windriver.com, dianders@chromium.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4 0/3] Replace the use of simple_strtol/ul functions
 with kstrto
Message-ID: <20241108110639.GA118048@lichtman.org>
References: <20241028191700.GA918263@lichtman.org>
 <173105511502.10030.8958584403113767756.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173105511502.10030.8958584403113767756.b4-ty@linaro.org>

On Fri, Nov 08, 2024 at 08:38:35AM +0000, Daniel Thompson wrote:
> 
> On Mon, 28 Oct 2024 19:17:00 +0000, Nir Lichtman wrote:
> > The simple_str* family of functions perform no error checking in
> > scenarios where the input value overflows the intended output variable.
> > This results in these function successfully returning even when the
> > output does not match the input string.
> > 
> > Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> > simple_strtoul(), and simple_strtoull() functions explicitly ignore
> > overflows, which may lead to unexpected results in callers."
> > Hence, the use of those functions is discouraged.
> > 
> > [...]
> 
> Applied, thanks!

Thanks!

Nir
