Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5D2951B3;
	Thu, 22 Jan 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093993; cv=none; b=RjcfhmMNp8xvMNxLXK5MUA6A3N8z6kJmQiWiMBeIOAD9BDJ3Go64SlC4WvSw4BMCxYq0bB2Q0pfcxZaS5MaVxCFU7ydMp8XvB3gDIDzWBKV3/QKtWUgbXNII1Jv2vVfuwXugocme3ELHFuWW0+i6Q2SJgsew00hRO4yUDjQarLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093993; c=relaxed/simple;
	bh=lc2cin+54BlkM+ZEutgGme+tA53nkIk5rWTHynL1PLM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KXfn7lxIyNrjyqHgIiavWRIBz/DthXGDdn3bTPRjFSa4VeESNV5gmvZXNv9nkUsSgmTacmD1sTxvtQ380h5UyX/Ej7X4IaJD1tFY6aEunG0kOtAHidTOk+61kV1F7kjLcyDJthKEkgV6cpDVoVfyJz2/lmgCJ5T3MSbyYh5O7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FtJi5M/J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FAA56enM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FtJi5M/J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FAA56enM"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lc2cin+54BlkM+ZEutgGme+tA53nkIk5rWTHynL1PLM=;
	b=FtJi5M/JmmUPIMeFv+yV24ueY07h7TE1MLqsdrg4y7uHrukTGs+hxQqcLgH0N5SJqWmWiA
	TPAgK0QHoLBcrsBNjrU4CHBYfr3yicDT/lGdU9tMZtP4R85Sii/sH86zP31MdWKQDd2T1e
	4uPb592UxikYHB0+i6OsKTmufuNBsd3zXlT1DvP5vq/V/dZXwgSa77F7pE85kJDLQGVm9D
	fzevQpIemFT/wDZRRcr8oxEmI81e7Zrd7nKmnOiiUxoa4r6SJqu6fMzp1L0K0vOEtxWZrr
	NC3XgL6MO+G2oRXIg1h5a2hCiU7vXy0LWDOcD8hBnqzpGaMR7uj0A4gH2lYr3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lc2cin+54BlkM+ZEutgGme+tA53nkIk5rWTHynL1PLM=;
	b=FAA56enMCihq7GKxJ6Y9kv1DSJ++j9kl8y8DFue0BbmPqswvzqXMRLPDTpzz1ObvppFSM1
	M/wi2zUobglo7yDA==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/26] rv/rvgen: fix PEP 8 whitespace violations
In-Reply-To: <20260119205601.105821-13-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-13-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:59:48 +0100
Message-ID: <87jyx9itgb.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:

> Fix whitespace violations throughout the rvgen codebase to comply
> with PEP 8 style guidelines. The changes address missing whitespace
> after commas, around operators, and in collection literals that
> were flagged by pycodestyle.
>
> The fixes include adding whitespace after commas in string replace
> chains and function arguments, adding whitespace around arithmetic
> operators, removing extra whitespace in list comprehensions, and
> fixing dictionary literal spacing. These changes improve code
> readability and consistency with Python coding standards.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
