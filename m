Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF57C4B8DE1;
	Thu,  2 Jul 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000797; cv=none; b=I+yVAdv0TLN2uOC8xetSTFHfnwyCY02PDC3DvJPAAALW2nhUxf7Wu8VpbyNM0SA+smnlvMaz1UtEPwOouogdpMxlFCMMicRbaRpUdyeeV+g7NNA6IdabfBQLKhwffjTS/Wiye7N41chQOW52mG23nqrz8vA31LemrSuUn9yXtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000797; c=relaxed/simple;
	bh=WhQ+uCYmR0tjf1L/JYukhT+q9+gPG7Ic/uoX5LiUHvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n2O5S54WdHmA5bZZzXwkRHpeTNfFJypnUZoIzAGWkavf7xeD+NZmB+g0sHZLtC4IONU048n4iB7bgKKZpBERvhxfeglIQSWRHgy17XN+f/jPZS7IeS4yRvClbch1PIoCT8TsuZYOF2sYpL5URxWC8/9FqGjWjyL4fSgoas0ah+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5l9W8kf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x2UrVjwe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5l9W8kf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x2UrVjwe"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783000794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WhQ+uCYmR0tjf1L/JYukhT+q9+gPG7Ic/uoX5LiUHvQ=;
	b=y5l9W8kfnBL95uc5EpnirwifN6oWSTqCygc2Ryhf+KAtswSKRNQvkN+wtlhWv7DD/7HRPt
	r+W6/ATKOqi7T9ssoRsJanqGL7iLDf0hezQpGKXf4xkknzuBBOKvn03TB50eOpOj7CCntN
	DR9G1etkvgRHqrc+7ORlwCNzy+2eW5DGRnDCNX7ED4LpkTy2TitD6TBq83RT+qxafQqDwG
	vQ3qs8eMRz4RkMrS8mLYsIj6ufxU6fwU1n0ZMusy59rRoMlavlTqP3sCw+UJf4fasH/qi9
	CNhdwEkddj+rdraW791I6dGMJLLW1SdWYkdIeOhtELYJEvDzoO1EoxLaLQYHdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783000794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WhQ+uCYmR0tjf1L/JYukhT+q9+gPG7Ic/uoX5LiUHvQ=;
	b=x2UrVjwew7FYHFGCdbF39Ik1CZoK9rS5XzAIzNkZEgi2UQWGWBQaP6yfSK5TodppM88rpk
	Rd3+6P7ehtm9QuDA==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 07/17] rv: Add KUnit stub to rv_react() and
 rv_*_task_monitor_slot()
In-Reply-To: <20260625121440.116317-8-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-8-gmonaco@redhat.com>
Date: Thu, 02 Jul 2026 15:59:53 +0200
Message-ID: <87v7axijae.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Add KUNIT_STATIC_STUB_REDIRECT to allow those functions to be stubbed in
> a KUnit test. This is useful to catch reaction without creating a custom
> reactor and going through the effort of setting it from a test.
> rv_{get/put}_task_monitor_slot() rely on a lock, but this isn't
> necessary during a unit test, so simply skip the calls.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
