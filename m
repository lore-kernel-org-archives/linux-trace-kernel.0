Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8396435C183;
	Tue, 16 Jun 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600458; cv=none; b=JfnBCwNMe3trtjNS9D7QNyAzklhdKXUl5JrT3dDcsJ4yv5xjqrL2IbmGysFq9/xJbOPj7BxDBBBCr3d/5hiegCmzylAcMM9XJpxDq/zx/cz9lFkOVv0gReR+L3xJalT34LnvbBY57z+qJKBT+OfW2gUnsyXEMpthH8ljKZs3N5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600458; c=relaxed/simple;
	bh=NXhTY/xac/3flzPL5o9G8Q55AVlEc5jpIp29XToSUws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oC9nr3zAJSUY7yUFpe4onYCNNntXDIXJTnIppK2GEoHOTAWorj222dd0eknI7tuRielzWgzKPIxZuYdzaD5GG6pIg1sLEWQ8RA6rjlOQ1mU68OHmwQROxJPPZcQ2C6PW8phTdSjObwtSYki+PC4TO78HKkjKurY6X+VDVxlgacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PLNN1HZ0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xuR6wwYa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PLNN1HZ0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xuR6wwYa"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781600449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXhTY/xac/3flzPL5o9G8Q55AVlEc5jpIp29XToSUws=;
	b=PLNN1HZ0t5xn2bKJiMnp/tHhlAHxMdYYhmzDr2hlb12JyJ6pzINHwlNnrKHKSZifiGeCqw
	qfImxdQ5yWQC7QT7vcEq9UGLLHhN13lTWaV6iBnijr98dikWbGYft9t8HzVM1zVg89L9ao
	hGfKkHeyqBDvo0wSwSyZIZ2gs0Bjn3CNDY1ydtue/2IHuqptkavQK2sJAAvEt30FNHQ24i
	oml344kjxav7AN062yWdAA+4z7PtO85QRVF9IiE3DTAukwFiWgtm0KKfmJE08jptcFCdv3
	34buJMRQxnGHfMibPw7hyEJj9PEFhGckVO3lfd/NfEMTp6comYVhuZoY6/pNkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781600449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXhTY/xac/3flzPL5o9G8Q55AVlEc5jpIp29XToSUws=;
	b=xuR6wwYaeNuQAxBpxRBnQdywTUiKiisyEBVujfcm2MUDHAjBX6vBgKKhlB9ahalWYoOr5F
	iZkzr3T8JpgDR6CQ==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] verification/rvgen: Convert
 __fill_setup_invariants_func() to Lark
In-Reply-To: <ded9af4b0cdde4696c0a295e0c622a9d39c445ee.camel@redhat.com>
References: <cover.1780908661.git.namcao@linutronix.de>
 <e5f62eab0210df74ba5dea5c99e218b39d331274.1780908661.git.namcao@linutronix.de>
 <ded9af4b0cdde4696c0a295e0c622a9d39c445ee.camel@redhat.com>
Date: Tue, 16 Jun 2026 11:00:48 +0200
Message-ID: <87ik7ivozj.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> val is a string, doing val * 1000 repeats the string 1000 times in python!

Oh crap.
