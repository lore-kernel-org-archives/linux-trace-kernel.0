Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EAD72618;
	Tue, 25 Aug 2026 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787640595; cv=none; b=iC0kQuvOexD77IhQNAvxUZ2nnBKoZs2ikLvI++hMjzZJ2W/1bSECychlyrWDaz1BzdktTlTZcqR48QQYUpOkoLy5fFxgEDaSxV1CPhns5N2IMIE7yoR0ZOCndbtc3QFDmcLrMW8oQPcfkXznGbOpLxRG908dCJ98b+B6gqsdxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787640595; c=relaxed/simple;
	bh=yJnQtPsZTVg6BWepTW0hqJGkJfn5Ue/rQMxr8xJYd6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mSuL1LfcDF0/6LD50vBf0rs3ZtnS+daKHLwc6y1IThjX6sBNLHAhKeVweBEcw55OmenX7G1/mz59uHbzHghEVI8EVCr92p8x6PRDDNMDLBWHzH9RByW9Wsea/+sEn2P1ATVNWXz4v9w7bHxjKRMPEPJpW8V9LLXfgUGSrBQMPP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r5nohgQH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ApzuEKQa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r5nohgQH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ApzuEKQa"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787640586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJnQtPsZTVg6BWepTW0hqJGkJfn5Ue/rQMxr8xJYd6U=;
	b=r5nohgQHDLH0zTYCV+hRITTeGR371PoyDvcr2zRHlTPl/VpUcGugB2enIck2IyeE6Y48h8
	1TZmpzEmrI7c3piJteDazXiEc4MzKZMHVqKHTWUDASQbtwMfzKexPnjswY17hFZm5E4FBB
	PB4exPJuAZpq5qcW8fLz5LX8oEvPaQIRS2gH93xPPyBFs4Hnb7naxWSjT6xmdQs/8vY9u3
	tV8ORAzf/fpzM0yxwE1Y6yBq7CnTHiDXR28NAusPSCk59HrHGdSWmeeBqmowR/gwYNR7yr
	tcQKpEpjxhGohpM7mh4hNMu7KNTNrT+4emGNe+G4WOOQGxtVbc570+ingVC8Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787640586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJnQtPsZTVg6BWepTW0hqJGkJfn5Ue/rQMxr8xJYd6U=;
	b=ApzuEKQakfRoq81k0lUxqosQBVpZ4lEm5hGjCaTWZwoTKaCLME0i6POk3UEspR04MzCAKb
	BARsaZPyps9FiuCQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: Re: [PATCH] verification/rvgen: Use .old instead of .bak for kunit
 backup files
In-Reply-To: <20260824081519.81103-2-gmonaco@redhat.com>
References: <20260824081519.81103-2-gmonaco@redhat.com>
Date: Tue, 25 Aug 2026 08:49:45 +0200
Message-ID: <87y0du7kza.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The rvgen kunit command generates .bak backup files and these can be
> checked in for selftests (make check). Clean targets like make disclean
> remove such files, leaving the tree dirty.
>
> Switch to .old to preserve a clean tree after make disclean.
>
> Reported-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Closes: https://lore.kernel.org/lkml/aosuwKH5GOEo0xTN@google.com
> Fixes: 7b6246294eb0 ("verification/rvgen: Add selftests for rvgen kunit")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>

We should send it to v7.3 as soon as possible, to avoid further complains.

Nam
