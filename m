Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902026D4FC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306223; cv=none; b=QEJv2SbWpPOakz9M5ItXHezw0CiwWOFvYttBw4aYbIuIJklqdqQlV7byOtco7pkRdeBmMlHHzpDVLzfuKB9HJJbMdLbEa8ejOdCXcjiViKAHRgoIkqlfBCmHPceGKJtyy44QKiKDL9/ZauIMhSUa25Mh8Xsfy19M09k985VUvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306223; c=relaxed/simple;
	bh=yjRMt+arSlSCtRI6oS1L9afVVTF7+GzuoCmwkUVVLaE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IVEM7xcyoCiNJ20vlPDQjI0GNaHjJraCrZ5hdvxi6nOG5DWEg5VdrwFB6VQV6m1auSyhCTCA2Wi/VJXtUeepdr5Zsa+ximO85DnTJbr/pbG53v9zrYbL4Qejdx8zlZeVQjm5UrY3cc8L8w9n8ludI2Zs0t4p5oDWhUE7Fnrp2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vxmjvvWZ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vxmjvvWZ"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753306209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjRMt+arSlSCtRI6oS1L9afVVTF7+GzuoCmwkUVVLaE=;
	b=vxmjvvWZ/xQfWRmnYd6/ZsdTOFJHl9v3zM/yLmVDe1fySZMFNVRZOo+GTqrP4a9HsYj62q
	D7WXcYGZKymNrLPUNZnmLAan+sYtQaDCLMT1Okw0jpBiZxzgi0eaBsUg8uwOtg5IHh7iXd
	b2ynl9COlPcdTS9zz2dE5L2IY4wkKcU=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH net-next] tracing: ipv6: Replace deprecated strcpy() with
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250723172114.061cc226@gandalf.local.home>
Date: Wed, 23 Jul 2025 14:30:02 -0700
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Guillaume Nault <gnault@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FB903426-ADD0-46EA-ACE8-96A3C15B434B@linux.dev>
References: <20250714075436.226197-2-thorsten.blum@linux.dev>
 <20250714123825.6f0485c9@batman.local.home>
 <F998F71D-1244-4154-BC5F-19201C23BDBE@linux.dev>
 <20250723143625.79ab2c16@batman.local.home>
 <AE36F453-DEAE-432C-9CDA-0D2DA875CDA2@linux.dev>
 <20250723172114.061cc226@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Migadu-Flow: FLOW_OUT

On 23. Jul 2025, at 14:21, Steven Rostedt wrote:
> Isn't the above pretty much what I suggested?

Ah sorry, yes it's the same. I'll blame the jet lag from traveling :)

Thanks,
Thorsten

