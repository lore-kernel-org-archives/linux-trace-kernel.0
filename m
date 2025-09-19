Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C92E62D8;
	Fri, 19 Sep 2025 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272637; cv=none; b=a3g+U7EEAyuNByUqCayQ+urIQuBLPXrwsuJsDzGZ5Ehkqt0a3cgsiy0Cp5p0yVcL8DUTWk+5m2frwYaE5EiTrtzrdTIbp7jItBDIz04YUKzlUgRWF7FIYWAeht7+6DHZ9uafGoV03SZDynBmZ8Le2Nz0u8xWmgoRHRwrRy2HoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272637; c=relaxed/simple;
	bh=b9RDql3bXzAh8lj8mmXJNT+FU6hE22HIkNlHkLIRjhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KzXIQKwBJ7t/1QcpzAz55dxPecjFEmLi/UpqtzitDIRdbowaE1FhPcAsIYow0FQsZR1/I3aZ0XAWEJ4N85bGSfftQyA/9zubFF3B6EXinnaG52YlkBLFsPOQFKgcF3NYl1YDaNrf+oJlvHsYBpevofAoJBOzTY8WZPiqtgdaRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ES9i0+vA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WH5ud6nV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ES9i0+vA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WH5ud6nV"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758272628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9RDql3bXzAh8lj8mmXJNT+FU6hE22HIkNlHkLIRjhE=;
	b=ES9i0+vAk1XqCdRAngZ+B/euHmXkr7bR5Bl9a0BURagfcbknXAwHWRdA0wX8RfQeRQvgF8
	d2FeI+QnNcYcQOJf7F5p8cT81kIwx1K2uqcdxbo7bDEtrndVfcvaeH4cQnxx8EMZlb1LAJ
	ADhF7acnRLqzXrCaDsA4aanBZpJo8oJjFkJCqECDAPGam83MdvGRbwJKFBFlpRZW5EMbu+
	IMPXgTQLY6jWR1NU6IAST6UwFA4XR1zC3JYYvCcPLhQQtwYO8q2R/rUc8U0HMcrZ6bBYbz
	ZAQ/AGt+i4Gb/qGS1E+I60sGUU2k1PxdikHiwchdy8rsBOWgj9vFEXUK0iJzyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758272628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9RDql3bXzAh8lj8mmXJNT+FU6hE22HIkNlHkLIRjhE=;
	b=WH5ud6nVRDvbZpTz5HcPZd+vD0g40TqbKnn/XXi/rTGrlCpUu2xcltU568QN9U4o1FgjOJ
	3Emq71ik+p3IscBA==
To: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 nicolas.bouchinet@oss.cyber.gouv.fr, Xiu
 Jianfeng <xiujianfeng@huaweicloud.com>, rostedt@goodmis.org,
 mhiramat@kernel.org
Subject: Re: [PATCH] rv: Fix boot failure when kernel lockdown is active
In-Reply-To: <e7ed86066c53078ca55c1ec5c47da7b57cf2ffdf.camel@redhat.com>
References: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
 <b2c19df4c5036e956e4e892ac983d5488a8b9614.camel@redhat.com>
 <87wm5x18bf.fsf@yellow.woof>
 <4e8bae6a0ada1d52893381e7542220973f0367fb.camel@redhat.com>
 <CAP4=nvQubUmOVivgzOtYRhMmZaq75WRmRdBnsn0HYJfHHZhzmw@mail.gmail.com>
 <e7ed86066c53078ca55c1ec5c47da7b57cf2ffdf.camel@redhat.com>
Date: Fri, 19 Sep 2025 11:03:46 +0200
Message-ID: <871po295l9.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Moral of the story, better get the compiler check things for you (lock
> guards).

I will make the patches, once I'm done with some other things..

Nam
