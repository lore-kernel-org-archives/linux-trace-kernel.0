Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F02EFD95;
	Mon, 20 Jul 2026 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533719; cv=none; b=uBCLBN7TAsJiZWd2flrARD8sffxwFg0yp9Ed8ieqoRo5Tz0ngB8+IvmDSr+EXmqSt2wsapvrIwshSHpkxWAcyWOKmKs8pcF0HUTeSxY0pRZUPEoM15vejTSIHTaWAh3D0gT1H0JL2Ngcvdz+7q7S+DO06grq4QeaD0GJkTJlGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533719; c=relaxed/simple;
	bh=gDOkE0u4KMNDEJepCF585KcaIlbt3hX/DtJzmIhLxBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dfsZtzkM5MBbvkMVtFzNZ4JmViUegYA51B1HYoWOoAIjyfS+vI/hkZwLR96qZFJ450I9BmXDsSkJNk/6pmdPgZW7lbNoE4nuMyw6BoefB3db2l+uJiMx/i4QSxKMb5dsKMJZBYTnlWUbqHkHpf4CzMtE6Z8+Ajwq49AaS9xT69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vgIp99By; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OtmQ+3cA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vgIp99By";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OtmQ+3cA"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784533716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btqPZ41wKsSSBzDsbCT6vOuUX9yO4JHpx/pR0F2SGOU=;
	b=vgIp99ByOVFRQRPd5B7ig8HZaollx2Bp1baK0+3wElpjCAsbUntiUug2dbnQ+07TzFECV3
	SftblDwpPJCwPcP/bxs6wP+MSDg3P+LymKTGETvyElMqzZW+3stSFiJWJ5MAqpLohIW7HI
	WS1ICLxmomGoFsj8DH5M0sEceXbfWHNLlxkqaFl2GYXut9wigSLaZHC2j5a+l/ATo9dGEP
	h8PZlMrgWno9VjRdWbGGrpUolulLFSb3OM6oWapkFXcG/LWbSuKyRhy+rbYW7Zykp9zJkW
	NoLHDqdKNKvzqLi3sre1tEZCqxlq9KjP5t05vTS9veEq0YCUuMWea+StOsZbJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784533716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btqPZ41wKsSSBzDsbCT6vOuUX9yO4JHpx/pR0F2SGOU=;
	b=OtmQ+3cAHmM3u00H9szC/O8trVz+0gDsEg3WztptQuWDy49pfjgIM5NOTi0nPkUXAzDQ3o
	njBJDfZu19Hn6TAQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v4 04/17] verification/rvgen: Use pathlib instead of
 os.path
In-Reply-To: <20260717154638.220789-5-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
 <20260717154638.220789-5-gmonaco@redhat.com>
Date: Mon, 20 Jul 2026 09:48:35 +0200
Message-ID: <8733xef6ek.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Migrate to the newer patlib library, bundled with python since 3.4 to
> increase readability over using os.path.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
...
> +            Path(__file__).resolve().parent / "templates" / self.template_dir

That is an interesting use of the division operator.

Reviewed-by: Nam Cao <namcao@linutronix.de>
