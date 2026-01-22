Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052F366816;
	Thu, 22 Jan 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097670; cv=none; b=s5jEhfhpeozi2plgKyKNvAQiRK3AwMqX3dGGxendnKFsiLthLBYmuKE89IwpiKVo3KGjFA5xA0wtAr29N9STnF2WahNkcOspBlIHgF8nPC7l0fyw10o50+WMcpNYu1Y0oyzJRt9tFQhFFJgqiL/gcNPBk/C98/Dtnc9/Ec9GxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097670; c=relaxed/simple;
	bh=uDc35mQEt8KeHQA0HtNFaR+rnMihPpnwqVLzFP57v1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AqcpGcDQOYvcTZhCFAIghkVc8oQXKEAp83eDmSlWGmpXy8tbuhsDHZrM9frvcbNp7PQrSxAKbQv02wU1mJ9vcn7ArJYCahFLd/Z3gcIV6yuhyAdj6x70kDIkGC+QRQ0VJCUFXFx00HzHWah7Ph9Is298PcLm6ieD1Kjtmje0L/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gLBjPh+j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DdzT1E9n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gLBjPh+j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DdzT1E9n"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769097662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDc35mQEt8KeHQA0HtNFaR+rnMihPpnwqVLzFP57v1M=;
	b=gLBjPh+jCNAd6TYDmPmG3vpcIxxzPZ8xWw3VZs08qmPJRhadb7R53O2JQhRzYhKzYp4MID
	1QJLARw5HVZSwFmZ3QCHSYGX6AehKY9sCzMSlqDT8n3qTDX3luXHdDWEvf9lgfSIVcbmaH
	lzUimu/E+enf0b89qHTxgloQWxyka7jDIJv9hv2uVRIr12XMF8MVPAz0OgMT4lHG6sHnnB
	2SqzhDl3VvJQBQbR08WrSjxjz7KEbwyb0V8r7dlacs9fYX3ZZ9L1ixUj/sXqVsgpR9UpOM
	PEoMJxHSGBco/U0t6pF4q01op+QcA/Ibwpdu0/6fBUkh51KUtrkGjcxDzk3SNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769097662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDc35mQEt8KeHQA0HtNFaR+rnMihPpnwqVLzFP57v1M=;
	b=DdzT1E9nRNygSXrt7rZGA9sg2RubfIBobvQbpk92toqmjkumoVTyTKvpXQyljRxq+dE5Oy
	EOgE4Nr+KeWG9MCQ==
To: Gabriele Monaco <gmonaco@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 20/26] rv/rvgen: refactor automata.py to use
 iterator-based parsing
In-Reply-To: <182e75fa8339adb4f90f7c2837ce985ac98e1b80.camel@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-21-wander@redhat.com>
 <b024746953391fbe87427f994a973a212c2fb445.camel@redhat.com>
 <875x8tirtl.fsf@yellow.woof>
 <182e75fa8339adb4f90f7c2837ce985ac98e1b80.camel@redhat.com>
Date: Thu, 22 Jan 2026 17:01:02 +0100
Message-ID: <87tswdhc1t.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> By the way, I just noticed the ply repo got archived on Github [1], I wonder
> this endeavour is wise, although ply seems quite ubiquitous so someone may step
> up and fork the project.

Nooo :(

Let me figure out why he means by "there are many high-quality parsing
libraries that you might consider using instead".

Nam
