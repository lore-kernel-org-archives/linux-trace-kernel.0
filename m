Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6B1C4A10;
	Thu,  2 Oct 2025 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397222; cv=none; b=Gx2QmamtkJlOPwhfDoUAGjevR4FYFZ+GlHSyOfkBsZbhJNZmQV9+xLyavxjSY0iFumnhBkkVNvM1NN6Ig3iMZkVsGLm9Th6Yl1vkkgmPu+0+/tZlq9l9HA3hG80DLqWBCVAmgS6kfBO3YoGVAhwUb81kc51UsijVfpQQm1xY7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397222; c=relaxed/simple;
	bh=eycOjQiaXvlmQf5V8uRpGAlL8tXZqurGMiJ6dFHSTUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSieDlfeMU86J3P1ZZD/TxC1qzGrGtgsy3XlzG7WSy3VTyBtoG4NdeAJI6+PJSZMobob7FAdQ4GkqGEbufDuC5xut6RuY0O4Q0e1rmoby0TLPlstsIKp52+J+T2z7EYBARsinmnkAYtmYMg/GsvO3Er0zzWYSZHNb38tUpgbGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eRDft1Cx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4wA2Q6GO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eRDft1Cx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4wA2Q6GO"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759397218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKZlguMJEYVUCG/7mFX+YaYIDG8DEuTUnMv/mBDZ3TM=;
	b=eRDft1Cx0obot9b/VNKkPoADcZq0eRVUmssnuGCnnImyQPkB4xfX3R8UsN+e9Jip97r6Zi
	e6QpoOWO8GKy8LZLGNL3Sj07tNcleMqUlyWfmFGqkphaSf3m4ECvOu++JZdsehVx6m0LZm
	YYm9kyFsZsxfDF05pTJ8r+8d6hFk2nphUxuGVLBVYdIhKp45Rebamp7NYBQqwaPR8C6Jia
	6bTdi0fJge+yBHNFo3a9YHujp/sTyY4KajRbSMmrCqUwtIXLKcsJtqcz+mQpMPTXOt2Rfn
	DGneyaDAwtWOsAmjAEwgmrXpdRV1esBswly5rmO9OokNvzKXbtZLt4dR0j5Ofg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759397218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKZlguMJEYVUCG/7mFX+YaYIDG8DEuTUnMv/mBDZ3TM=;
	b=4wA2Q6GOy9FOpk4+LqjXQnp9DzDUb1bGvkcSKh6+iV7ktztrAy38YtrjO951Koj9l7PRiw
	0lE95ciLsjo/kfBw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 04/20] Documentation/rv: Adapt documentation after
 da_monitor refactoring
In-Reply-To: <20250919140954.104920-5-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-5-gmonaco@redhat.com>
Date: Thu, 02 Oct 2025 11:26:57 +0200
Message-ID: <877bxd7ixq.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> Previous changes refactored the da_monitor header file to avoid using
> macros. This implies a few changes in how to import and use da_monitor
> helpers:
>
>  DECLARE_DA_MON_<TYPE>(name, type) is substituted by
>  #define RV_MON_TYPE RV_MON_<TYPE>
>
>  da_handle_event_<name>() is substituted by
>  da_handle_event()
>
> Update the documentation to reflect the changes.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

This is probably best reviewed by someone without much RV background. As
I already know these information, I'm not sure whether the doc is
confusing to outsiders.

But from my point of view:
Reviewed-by: Nam Cao <namcao@linutronix.de>
