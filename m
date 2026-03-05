Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE173CE48F;
	Thu,  5 Mar 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727161; cv=none; b=fhMVNfFkVlERCWJkdU82eqEWp9ndvz9q7rEqxeVcwDVa0hToFdA7rMt4IGjdobiJzF9ShH+TOJBMVhkgfKvhHQVYLsGy7BgeRKLt648343J1fiFzrF6FoFjqPcKlogGW/knAP6O33QI7m0Z0e5KZR7OoarQzGCMO6KlBfJt7yjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727161; c=relaxed/simple;
	bh=c6EKYDX5VRUP5zuUqQiObUXeJ4E2BosPNvpwZFkd9Vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qliedEvfHbDJTuKropTooeLkeJWu/+KvADusSgsJh4BBCj+SqDJYd8dbYwIAr4rhCjsnz54/G/hVZ4hnIGpsEwaeNbnfx1Dmc3irxcn7xRJz/nJaAzWUqnZ6A2DJ72d8LBdY0gU6NiTqVg3cze9y5wTFr6qd1Es9FxrixfU7sHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rEj6T7J+; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rEj6T7J+"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 09CEF40C6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1772727158; bh=c6EKYDX5VRUP5zuUqQiObUXeJ4E2BosPNvpwZFkd9Vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rEj6T7J+38xFJ3C7Xh/zUQzP6LW4F1V+ELrjmRtJq0iJuUhC+kUnk0FwbdLYoH8S2
	 jw0TSMuMlM2YCYLsygVwsKL9HBktEFqj21YO+gSpm1V5NjqaitfO5B24JvVZvtqx7o
	 k0NqoiI0AbefwtWGoK2IJjliwg1fNA9Mox7zx24nxdiQOezznEXmISya+MhqkjPXy4
	 Mgf6fwsf1y9odB5W2JMKJuHu8IQDPyrjsKN9q5qmQDoCkr9WDAT+q+J/9+IO+jUJ8V
	 FAs7hFCVFC5JwqDsE2c/EhTuRShWjj/84l0pnczqHgPifdq9TLKuYmauf+AvsaMWr/
	 o8PcQVu3+Vn2w==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 09CEF40C6E;
	Thu,  5 Mar 2026 16:12:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Documentation: Update histogram-design.rst for
 fn() handling
In-Reply-To: <20260305110347.31d6bae5@gandalf.local.home>
References: <20260126181742.03e8f0d5@gandalf.local.home>
 <20260305110347.31d6bae5@gandalf.local.home>
Date: Thu, 05 Mar 2026 09:12:37 -0700
Message-ID: <87pl5i2r2i.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> Hi Jon,
>
> Can you take this through your tree?

Sure, will do.

Thanks,

jon
