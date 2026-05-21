Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB823D7E6;
	Thu, 21 May 2026 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332300; cv=none; b=ZuUlWw0AXlA3c4CePDsSW4zEt/4J3yaZcpU6ttFB497Vy4NQqC2c7c2ZQ2ZdcGVC3KYtU4U67LOGoLJekC/L35MWRX52jmvq3XmNkpnPBdYvpS/cFHcOBMeGyeqvOamrNeO6dAeE5ne4+t7n+/OUTT6XamMNyUFbMrER0ClG9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332300; c=relaxed/simple;
	bh=C7xeSB1eTJVsNBcy9N8msTMyFfTIgg+hUe0ZZ4QilX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiTj2mvyIQbnF0mBZPefv3/vsYWH2xyY5y6Zd3Zxj7xBO/uuZSGLxUicCIUxU6BeiScvIL9+iYLNj07UrAl5YsXEyAiDfPi7OFhB/eR9/X3Ugn9ezzb/pqdVf23q6OiiHYS7hwzx5gez3p7Sl5uSDN1XcR7kwGOw8SlYgCbj32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJYlOLuQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJYlOLuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49531F000E9;
	Thu, 21 May 2026 02:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779332299;
	bh=lgNDifqdpW8mk+0gb9ENgrlonB3Oj0w6VdDToo9B1Xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nJYlOLuQoK1pWC815/8Cz3Pnv7Jb4mFILWk9Gd0SjE4wXt4dwcZTLdoN1bmJgWKpa
	 NQAv11oDbNDuKzhxIgNrOGvKEm0uc+ocG4wje3SwKAZjyCB2vi3l7Y5BrSb9LV6qYj
	 eXEk5PVc74VNr/VZzo1CZXvdGW1XpMqN7cwlAj/E6sG+rs9pkHmJd6Mf4rqSkzUlc/
	 MCc6sZ4/+T6RgPlHuLzc0lSLKLluLN1dCwEJtQp6EBurK9GEH8b6WHqVDAGDfNYiro
	 Q1+MvSPinmeluRdKkToEQq5O6zGkFlixowS5mQwg5epN/8D6VHTRTS7JlJibldeYpm
	 Djz7Qd8rxonPQ==
Date: Wed, 20 May 2026 22:58:08 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v20 07/10] ring-buffer: Skip invalid sub-buffers for
 iterator
Message-ID: <20260520225808.024fcf4d@fedora>
In-Reply-To: <20260521115125.a2a1d90c5913bd4d27cb9107@kernel.org>
References: <20260520184938.749337513@kernel.org>
	<20260520185018.051228084@kernel.org>
	<20260521115125.a2a1d90c5913bd4d27cb9107@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 11:51:25 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Fixes: **TBD** ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>  
> 
> Should we merge this into the original one?
> 
> Anyway, this looks good to me.

I could. I never know how to do this really. That is, I always feel
uncomfortable modifying someone else's patch. But I could add:

  [ SDR: Added skip of invalid sub-buffer for iterator case ]

Above my SOB.

-- Steve
