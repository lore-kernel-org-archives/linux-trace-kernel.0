Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810F3264D5;
	Mon,  1 Jun 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300822; cv=none; b=gtGfbmB7ZLzwxzgu8jaVW8qlXMqtvoL0M+L5k6n+Z5U/yKLmTBAj6kBtVEYAoMxgGnIBszo6g9WJSSYFkQRXqwqJumaH3MWlAgFVN7O6fWjqjuBdUBBPmjw5baomYFPng/UIarYXoVpzPQtlD1iljh8YOHWW9MRQddwEa7+nE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300822; c=relaxed/simple;
	bh=eIUnzSF+Xy4E9BE1wwMlos3FfFRH+p6VajN4/8n3mQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UdLathgXdiqUwqdnte4nqJYlaRsYzKrTjh7Ecn/wDaaaLmSnK8hIkQlJ3gGkhZypUFM4mtPKWdXChpCd9Wdf4kIDsTq8uyPYH5hR0CX54y4j65hr26h5T194ODSs7VGWHWJISss4I1AzxI1lei9dilHQoxpSr18ngDvZwpUIGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DxYMWOeB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GriQvaWo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DxYMWOeB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GriQvaWo"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780300820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eIUnzSF+Xy4E9BE1wwMlos3FfFRH+p6VajN4/8n3mQI=;
	b=DxYMWOeBbkZQ0xn/Tp4cs8D0dco2kaqXz2CcfEPVL6Htk+9pCGzJihQIgnMKnEIgLM3lbw
	FeLw3o3wsN+z6gSaTjqawZmr8u/9mU66fGHgGbVxIyggd9aprrQ2APov7fvbD7Zej/LoMy
	on4w+WSQZnDxQS/ZTi3HMWnJCbNveTomlzjHRDgSQvqY933jRLqeGqnqNlk+CVtNfDsa9w
	oGc/ztq6Ttgxv6F535HjZl32DRpRD+WUsymQL0ZUJnK8rZ8zA0FCS6r0AD/q+Ar/bqUz8s
	f9bXXuSPk5vYwMQPqx55vx/u17m4nLfR9xlPEhQumxNNnECWmRtROIC2aD7NAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780300820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eIUnzSF+Xy4E9BE1wwMlos3FfFRH+p6VajN4/8n3mQI=;
	b=GriQvaWojB4b5raEgP2+n5WgKDb7oBx8YfUDRHZpP+CTKIbwkUhkJX1Snxm9yieZbxiCfy
	wj8cB8gCEljdQADA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 11/13] verification/rvgen: Fix suffix strip in dot2k
In-Reply-To: <20260530141652.58084-12-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
 <20260530141652.58084-12-gmonaco@redhat.com>
Date: Mon, 01 Jun 2026 10:00:19 +0200
Message-ID: <87v7c2wuzw.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> __start_to_invariant_check() and __get_constraint_env() parse the
> environment variable's name from sources that have it padded with the
> monitor name. This is removed using rstrip(), which is not meant to
> strip a substring but rather a set of characters.
>
> Use removesuffix() to actually get rid of the trailing _<monitor name>.
>
> Fixes: a82adadb16894 ("verification/rvgen: Add support for Hybrid Automata")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
