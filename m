Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A104330328;
	Mon, 25 May 2026 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779709138; cv=none; b=l2e7kigolCOnBrO7z+c2c9yC92HDK322S0f3Ed6hmVc9O227JnDmPNjcPpXcKVcgjxt9UYkYe9xIZcuEcOa9URDFRSlf0ULD23p4L3XnL2VJokCStC8rS9zzu2m69KVFEMK0yfZ2evZYESl3RDQlFVLtUoT5JfDd2FRZ5L2fzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779709138; c=relaxed/simple;
	bh=CSsY+ngEdh1UfsRojrEsulllxHp8QzpwTME1UpnJRKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TL/tzJbc2KrUTY1LhZgFiKH0e30JpS4VzARYX7B6AxwzT46TPda2uG7vSa/ETwoQ1lXO5YkHFLNN0WJCvgUfgDi+XaLDJMRol8Dr7cs+jdIgKh1kezWu8km9dFXMK3a5cDHd58prNPKxeXS68UgIC1pOXkfxKZ62COWqjrSkZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NfolVpf8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z03dpZcJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NfolVpf8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z03dpZcJ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779709135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSsY+ngEdh1UfsRojrEsulllxHp8QzpwTME1UpnJRKY=;
	b=NfolVpf8+VCuZv9xwwTxs4kuHmom/wb7UqkmXoxqhmMkZuzY0q+vccT84L7grDFqmtxaee
	isCkHr5AFkK5EWawwyDK6jMDbM1S4+3QePpW8UvLJ1Kstf31IvOBRsF2LfUo8hj5K2RFBN
	p4BnNX3OAdF726k0kQA9+NacyelGSgIrBGk1Br9Z2Yi72bvaHFmmlfS9XhJDCAwiBtfgQu
	ow9eWw0v4mpV6bKslDgyjpcPGb/Iddmxx3nn4ZNO3e9Gu6wEEPBmPdEn9gb4jqJPEZJiz+
	QRkL5sOwU+W/OBJP+TxygddbcUDfBN3Vw68I8CX5/biV931JxZPAqJO5tEB/wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779709135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSsY+ngEdh1UfsRojrEsulllxHp8QzpwTME1UpnJRKY=;
	b=z03dpZcJRH9SOdedT3+qjDb0N2zSTL2MXnY7GoIQ+08FR8cf1jJZT1nOFm3iMqDi5icL/y
	nZAAciYkQxzwZmAQ==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rv/rtapp/sleep: Update nanosleep rule
In-Reply-To: <376235e7f56f4d7fe21c68b39e12bacb9d3e3d19.camel@redhat.com>
References: <cover.1779176466.git.namcao@linutronix.de>
 <a2175a6647bb88797ad8275eddb4b20b749474ec.1779176466.git.namcao@linutronix.de>
 <376235e7f56f4d7fe21c68b39e12bacb9d3e3d19.camel@redhat.com>
Date: Mon, 25 May 2026 13:38:53 +0200
Message-ID: <87v7cbiur6.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Was it intentional to remove this too? It seems to me now it's cleared
> only for existing user threads.
>
> Aren't we sure new kthreads aren't stopping?
...
> You missed removing a couple of these in the next branch, the monitor
> doesn't build.

These are just mistakes from me, sorry about that. Not sure what I was
smoking while sending these patches..

Nam
