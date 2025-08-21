Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D751DDC08;
	Thu, 21 Aug 2025 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765145; cv=none; b=OTVTeLZ45ko2dVej2lbmNY7huOoyiZyOy9ls86vFA193QYF3WfeQU5e3kwl8h1nF7UWcipEUN6jrVE1GoYc7MbqVgVWOl4AdqMA6D1qXMOxAn5bthJkh7wwh4IyeBOZb+pCGwqjp4odwWwJ7Us8MWlijX6kSqdlFGev1JqA87GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765145; c=relaxed/simple;
	bh=MXzMND9/w8Uvb8uniPGLMIvu44t2MBlsifQsMmH5/gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl59bUVYgJVT03f6M7/5nzqbFu0LZQw30QLoJNgKNQl7ujrwuMSgbPBlrl8U3RxxLIZJTLA/0kohNqvdxiiZ5t8hjnwo928/2csaUVHV59p7TMIIkeNZlf5bceXI/mZXul6KWPuyQUbsj/ZbMesbqi7LfCKvyDtTUEMZoNP5fyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4LDNC6Tc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TTGLwG5e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4LDNC6Tc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TTGLwG5e"
Date: Thu, 21 Aug 2025 10:32:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755765142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWx4NKMXcUpmwEc7UPc9sKKac4jDlYVu6tndFBEy8og=;
	b=4LDNC6TcZrtBuRVMpwoFxLj6VLp+OFww88oRjUztNarLDdQEs56xJVyUNhL/iXKVanXJsE
	J0Jw5J24VB3450tvf29RdI+AFqX+K3Mt8JpcvmgiYW2Kv4h40O1XpmHM3goEpe6sbG9+s8
	xtvB+KPwPN6fXKK2+dgQpwfuccRgu1GO/EU7tOMiP3+Sa6DQX5yjPUmeMCzlOQPECYq/px
	zZ/vAswwYVrkp1PjXqV48CzR19/KF2e6JnwUg3+mPAb3pdk1GD3CfnA6HHeBWCo0m2sQ6y
	CzcUtzAHsIHZAVqqA+aca1aVQPAiZY4AX9eq29zCoJFG84o1YymT1KO2OyVnJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755765142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWx4NKMXcUpmwEc7UPc9sKKac4jDlYVu6tndFBEy8og=;
	b=TTGLwG5eghtfzTamP6sQNsFNfKJu7M8cHhw6mAsCtC7fpf99z4JRvE8dmxUjombYL9w2R3
	UIb4G7KfDqXxJnDg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 06/17] verification/dot2c: Remove __buff_to_string()
 and cleanup
Message-ID: <20250821083220.iUpHo-YN@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-7-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-7-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:07:58PM +0200, Gabriele Monaco wrote:
> str.join() can do what __buff_to_string() does. Therefore replace
> __buff_to_string() to make the scripts more pythonic.
> 
> Also clean and remove some intermediate functions.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
