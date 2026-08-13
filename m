Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F00374A11;
	Thu, 13 Aug 2026 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638150; cv=none; b=sAEXZEhu6ul2ArP4T1aBQh232XHkbL35sqFNIiSkNqMdxUUmu/Jt4vIDHEYG2XUyWOV1mzUK9MYons6ifAw89nQOsNSKjvgpPd1u6V7eHTfdLPFiLiPLc5e85POiNgmV555Ub5wBvWqgvKFCL2S77FBcWE5gNxie5uxcK9hkZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638150; c=relaxed/simple;
	bh=FOsYGgBoLe5aErvtXtCceYed/JlY14VNGofHx3POIB0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=msMER0FRzRTz0Hu7gS8xZ7ZhL5fce5JZomDiVjZfTC7g9WgCRDtiICECSSKNza17lM3ylZ8uP7fP2FcrLomLQotUgwfBgQKoiSywS8KBzOWndDFllL2QrtPfNnYzeFC7cvwr447ra4oh6TCDdziv2O1IB9Ub8DGHZFoUAJJ5b64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHdLqst9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHdLqst9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C751F000E9;
	Thu, 13 Aug 2026 16:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638148;
	bh=UnduXndmd7rpMu1/05t/znNnxnCdGOqm/oY7N5LTUI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kHdLqst9Wdm3F4a2EmRe8cKN4SJI+hObJYDqDbaYE4b1gHn4azsofhvvu54CwJxPp
	 KU7DS7ZDkIQY8rqyCC+0QJUjybBKjfUSOXWGs1XokHDwCLJRq+fw8krX17o4OA4pDx
	 1cO9Wlp3iV6tdXftsfFtE84ic2za3w3j2M7j83ii7omgZpy/j2i2v02CKddvikuWkO
	 uVpABtQH6V4BLS0SYN1mx10Q9GJtoXt0si0/pkTxvPzxK7vyzY/EPerzFMVffwopA2
	 EGviohxiKUjlPBH40INO8FICsvJyL41fg3Hw/rIra8kPkvlcGfJG1S8hvT1DCM6xW6
	 JvicmFcXtlb9w==
Date: Fri, 14 Aug 2026 01:22:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 7/7] tracing: Parse filter from event string
Message-Id: <20260814012224.019f01054bfad020dee43494@kernel.org>
In-Reply-To: <20260813-tracing-cli-event-filter-v1-7-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
	<20260813-tracing-cli-event-filter-v1-7-57c4e8029c86@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 13 Aug 2026 16:07:20 +0200
Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:

> Make it possible to specify a trace event filter from the
> kernel command line.
> 

But how to use it? Could you give an example and update the document?

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
