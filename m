Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E78834;
	Thu, 25 Dec 2025 01:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766625370; cv=none; b=QrANSjgHIdSUhHtC+ZBiilVBTHrXN3wrafnSIt8LVIS6noRd32BsbGOG1goxRIOSz5j8+DNNg7PVStg+RhgLye5+RvuxdNMGalAPeGg3e0SP5TLuUyKMtKZo+JLNNMG0+LsCvF4aRv+8VxOecSGeA7/povZu4zjK3F6UpsUXcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766625370; c=relaxed/simple;
	bh=LOYmlOe1Vq/VYImbaMRny9/DAx9G21eUGcDCanz9mdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jt+BZApKCY7r6qnzfHe039/hiAT1SmkPYfsEIBY96Mbm0CLjk/962bU4c+MQvx2jRLjJEpTbxZph4tLKH17O9+PPre0Z/4jJu5Y8CqBj3ocdHdYQ3Rx0VM+mqB8Af3ofeGeft36/N7SwOlHTTUyK+mcshYmSfVq2OsG6IyvUix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=soDboTPJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+s/2MCpN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="soDboTPJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+s/2MCpN"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766625365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOYmlOe1Vq/VYImbaMRny9/DAx9G21eUGcDCanz9mdk=;
	b=soDboTPJvKuX0d1j5LOQ8+uafrFv+kUqHvSl9JhfaDEJxvC787f2DVRIUWriiS/rw6dIPf
	ZGorxnwPXXq+U+8X2G3BP57E1D+xqNWxHGNUB7ytCXm47CtRMQAvQ6GEaZb1k319QNMH+e
	KdltnXttJSlYEVPok8Lqg8m+Sh23a6O3h7zGvVyI9DjrdFhRne/H3rMwSEmrYQ+3HGdW1a
	eaya4HW8BBZbHZLIOvm7yGZ8MWL1KWxXnRi86VHEJLN5HG1hm8r3oeOSdeOhkbKlf9d4AV
	Z1PVJADvKAQebjQZpUEin/5JAGZzNfh9sh23AMwmW9vKp153NsAI7zi2+HGUPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766625365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOYmlOe1Vq/VYImbaMRny9/DAx9G21eUGcDCanz9mdk=;
	b=+s/2MCpN69NsMJzLMlUq53feMyZkCd+81GKiPuOdhJ+LBr3NceUM3JmzxMeE47HG9X7ES/
	RKW0JHHE/cVlGHBQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 05/13] Documentation/rv: Add documentation about
 hybrid automata
In-Reply-To: <20251205131621.135513-6-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-6-gmonaco@redhat.com>
Date: Thu, 25 Dec 2025 08:16:01 +0700
Message-ID: <877bubbbu6.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Describe theory and implementation of hybrid automata in the dedicated
> page hybrid_automata.rst
> Include a section on how to integrate a hybrid automaton in
> monitor_synthesis.rst
> Also remove a hanging $ in deterministic_automata.rst
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
