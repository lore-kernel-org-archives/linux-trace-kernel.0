Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75922EB848;
	Thu,  2 Oct 2025 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397669; cv=none; b=Ml8SCYSDVgYmneKcisMyO1UNVMzoHteBlfJzX8wvV3psi0PlDbN38HYwsDzv4f+LHJZ6FXKC1qMs6wtVMMeJwQbMOFbD4QvpT5KqA67Zq+7/p36hEoFR89ofHi1cBzQu0+v9rW5anMnvopDbG2qmIZnjUGDSSikUrxhAM6OJZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397669; c=relaxed/simple;
	bh=OwGWP5VU5aHInLgwHPRRHWtQlkApFlZiWjlMjt+QStU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SHRX4pvu0znntseYFUTThOva54PniAXo9bDcFymgnGA3QFysgkx0V7Z8Qp29v/hyEdKHdMXxBQTg0Zl/mMZDEoUO/GvoGqkLwVKsUsIWGttdqYqPAD8YaLH1LanCocSGkPrzTnCT+QMKl7XUX6oPlzZXToG8TCGi6W4aPcheAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fKys9iHF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/GmkcIQ4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fKys9iHF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/GmkcIQ4"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759397665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uehj3rSU3bKqQ/kpBNfePDkVzVhJ7ujOFpHUdUdYBaY=;
	b=fKys9iHFTF7Dp/4puMHcTGkO3r1wg3yaoBAEKkERdAae9Rmg1rVD1nQ21aoH87w1JiZd1Z
	0Ya6wxXNqomYflfM4xLsL9jXpJ9F5PZRN4/7dq7PVX0DRJ95IatTDzhob1jK4wVJ2WQRMx
	JCu+7okVa+tB4kfd6spHQP/VoWs5RcT4r2f7LoKJloqxfzaembMku/Uhq4f9ig4KpPdkNK
	n+lu5GzHt0DY/wwlogoIictNAgK0xPbShfdpA5rmxZpVp3/I9tSIpIWZ3mjTaaQ6Qn4hl0
	MfVbZhsiD2CV2CT4TskbBBw+yaK7uUC0BicfkXAMx1ir8nQ5XKShHfR8wSNQEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759397665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uehj3rSU3bKqQ/kpBNfePDkVzVhJ7ujOFpHUdUdYBaY=;
	b=/GmkcIQ4vFN1gbZjA4sadKPltfYGKuWZJ2u1iOdataDWLwwzksThkyBu0pQrHZuL6TVBqh
	Qv1ACNqUQO49V8Aw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 05/20] verification/rvgen: Adapt dot2k and templates
 after refactoring da_monitor.h
In-Reply-To: <20250919140954.104920-6-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-6-gmonaco@redhat.com>
Date: Thu, 02 Oct 2025 11:34:24 +0200
Message-ID: <878qhtsl3z.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> Previous changes refactored the da_monitor header file to avoid using
> macros. This implies a few changes in how to import and use da_monitor
> helpers:
>
>  DECLARE_DA_MON_<TYPE>(name, type) is substituted by
>  #define RV_MON_TYPE RV_MON_<TYPE>
>
> Update the rvgen templates to reflect the changes.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
