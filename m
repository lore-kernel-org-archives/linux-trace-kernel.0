Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E73002A0;
	Thu, 23 Jul 2026 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788488; cv=none; b=oGn0Xqn++OYDiT448718v9NeHn/ZHXxL2ORW1Sm8GjWTDw3/xBsVIVBjC6EQSiKZCrpAB2NbmvI0lKJ00ceEP9noGn+7KrJ0Xe+es68i/4L3lZo88DubPtzy9CBrqWvHFiPXURtw9Uqu3HsM3obLpQOsh7/lF6lPD+7fSB18b84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788488; c=relaxed/simple;
	bh=7oTP9qBOKLmAFIiJfr/ZaN4BYjll/JnjJhcMqLr+71M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovZ69JqoW9Hrbzrl2RjiE4CIFyDnYKe01Oo/62BB5x75A3Aoi42VumXpgyiVXEte6Uhr9leXlZrssIDc8pkOE2K0Oj2XmK5fsOHC03B4IDZqOA265Lqoz0mzYP9vEpFbY0SFBYUn61ZDm5u3DMcV37+cNW4s/6cGvrJLMcuq9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BYjTY584; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v1PYPs8o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BYjTY584";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1PYPs8o"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784788483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7oTP9qBOKLmAFIiJfr/ZaN4BYjll/JnjJhcMqLr+71M=;
	b=BYjTY584Bmvus8+YzCDYfmjSyfO/51EOt5vECqK7PXXmIYbiGEW3vDUZ8Le6ku4bKUsEl5
	aRu1nXuGyGqwJFbJtYvabsZM+atz078BbqY+MYqo9ADc39YmAvNumUHeZbg86mbESJaX4Y
	RTP9gX7PBQryNMHquxGc4IXF96+QIoWYfpBBE+hMhrn2Nhr/3w6VITZfmjfnOtByfEEuLf
	1zJ0eXD9/AxOse/YkoLjmh3n8gu40NOxLmWoShks2Rk4703tKHubfa3PR8ivLEJKQdt0nf
	QDelHeLeWhWjhxVg8wgUkJaDeISsT/sV3gtMXvJvl3fVFl4R6ukUz/DCuXv49A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784788483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7oTP9qBOKLmAFIiJfr/ZaN4BYjll/JnjJhcMqLr+71M=;
	b=v1PYPs8oWoBZP3NR/m2gzf3cCvNLsSAKi0dG1qB3Fy4tpvtNAXWT8LQIcPDLxq7aenAhjW
	Q90bXMskxaQvIJBg==
To: Gabriele Monaco <gmonaco@redhat.com>, Chao Liu
 <chao.liu@processmission.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rv/rtapp: Add wakeup monitor
In-Reply-To: <1fe191ba66ae668b4635e2dd18b3e6c3b3c0090d.camel@redhat.com>
References: <cover.1781852967.git.namcao@linutronix.de>
 <ba5658fa13e49ada466b84a2c211f233037180b5.1781852967.git.namcao@linutronix.de>
 <amBHR4JTr2InJDk8@ChaodeMacBook-Pro.local> <87y0f3wjuk.fsf@yellow.woof>
 <1fe191ba66ae668b4635e2dd18b3e6c3b3c0090d.camel@redhat.com>
Date: Thu, 23 Jul 2026 08:34:43 +0200
Message-ID: <87wlumb4e4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Sounds good to me. So as far as I understand, this change is going to go through
> a separate patch right?
> I'm considering this series final.

That's how I understand it.

Nam
