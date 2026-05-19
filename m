Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E923392E;
	Tue, 19 May 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195561; cv=none; b=ImvzbDh2Z2sKBb6G6jSkKvVN2wegqKknRk1zfgsCzYyuwEUYfpRUHerpDUeGN2mmufFDktULgBg4Y0k2EnCzQLctFmL7/eJB7nqV/hzpS+uRkjvKlLIZ/IomCD3Iist1rMMd4Tjq/ko6E2IX/z57iDKFz6XIZlRFA3tqA9b+0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195561; c=relaxed/simple;
	bh=6iGDtZYxOArOC3i8ob2cYfSWNCvaoAH24Nw9lCru0qk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UM8ZXOM3GPFnh+xUhwdTILjsPLY9wA50k/rlWbkEejvH/pLy9EKyxzRUHCs12HfpRQBmdU9k8ppgXgXk0mznR26KC8b/pEsSWEgne1wS/nxpvuHTr4AjyreziOkCn7GN+OHoJG3yBbGPxCMSC9bZUpIfENc3NfyNoj7b0VcnKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zW7/Lr4R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+2YxtD+l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zW7/Lr4R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+2YxtD+l"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779195558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iGDtZYxOArOC3i8ob2cYfSWNCvaoAH24Nw9lCru0qk=;
	b=zW7/Lr4R2u6qTW+ZVNu1u01v71REI5lia4cmK5x0x0aD9+38ozD0wNSZ2Tpopk9nrjPXQX
	iUeW9SmD+5sUrwXe6c8Tv9/BlGabVZkCEdPfdvxpjqVdFiEBYK1S7c0vhoqtiWoU4xMiFM
	CoNDeskLnqKpZY9KKVCa8vOOpxNMklrVXyBr7Emg1w7NnXfJCv1qFaUYAHU0YGjGCOvG8w
	btloM5QXsbHeKzHdJDlb+k+4ThH7S7VkdUzX3ty9G85jP3SNKq3J1qLQ74rjIwWcgrejWp
	yYTmmPEwKnqWi5FTbBP0ze6KF7+Y7Fzkvt5w6DT9Oj/4sdpeRbTHXNcZSx+Uuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779195558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iGDtZYxOArOC3i8ob2cYfSWNCvaoAH24Nw9lCru0qk=;
	b=+2YxtD+lCtVLdiO+ooKSVl/8gNrOwAud0DsVD3IHVibJ+icnqwY3wVHGKuiWe4hhzhLbc8
	N9hX6ZgwvgDUYZBg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 09/14] verification/rvgen: Add selftests
In-Reply-To: <20260514152055.229162-10-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-10-gmonaco@redhat.com>
Date: Tue, 19 May 2026 14:59:17 +0200
Message-ID: <87ik8j4kt6.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The rvgen code generator needs validation to ensure it produces correct
> monitor implementations from input specifications.
>
> Add selftests with golden reference outputs covering all monitor classes
> (DA, HA, LTL) and types (global, per_cpu, per_task, per_obj), including
> optional features like descriptions and parent monitors. Container
> generation and error handling (missing files, invalid specifications,
> missing arguments) are also validated against expected output.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Acked-by: Nam Cao <namcao@linutronix.de>
