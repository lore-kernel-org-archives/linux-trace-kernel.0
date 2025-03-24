Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4641EEA3C;
	Mon, 24 Mar 2025 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742860398; cv=none; b=k7cKLmBg4ggOZsdVJ8cjdN+S5BUnljTTCTcRXm6K+ybQQy5k3dTO6+8MoNRMba2VA4w7xFpSOD9IsP3vOpOM177U86V18WNrJdX3DGyKlHUBSi+9rYPh8LPsxWoXAvxmW10bZqfAJfhwhJMgzYyiedDqgITohXNrLgKadBszGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742860398; c=relaxed/simple;
	bh=/KqB1el0ZVQ2ZOx+LT7iOeM+4xlZHBKDEX6l6IZMYeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaNmtAuP5X6BmL7KlDGnwo7WzO/CK/jkEU7qHNOwb0rTrm2/TKVNuD4ZJ8kKJeXKGY0Xp0FeWCzFQKp02w2xD8NPFgg7zsaBNSOHNBUeDLRKL1fPMx9iSsiRwWFJr1izTdZG/SOnLIftFafNcu6VvTNl/NZP5yEUpwROlcvQLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBBCC4CEDD;
	Mon, 24 Mar 2025 23:53:16 +0000 (UTC)
Date: Mon, 24 Mar 2025 19:53:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Tomas Glozar <tglozar@redhat.com>, "Luis Claudio R. Goncalves"
 <lgoncalv@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH 4/4] Documentation/rtla: Include BPF sample collection
Message-ID: <20250324195359.7e593f2f@gandalf.local.home>
In-Reply-To: <87cyefe0ky.fsf@trenco.lwn.net>
References: <20250311114936.148012-1-tglozar@redhat.com>
	<20250311114936.148012-5-tglozar@redhat.com>
	<Z9A1oN_XdMguNgHy@uudg.org>
	<CAP4=nvRCtRwXReMt8+vxjLVqtL_pR9OyKo0HS417+93QR84mUA@mail.gmail.com>
	<87cyefe0ky.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 16:47:41 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> What is the intended path to get this one upstream; should I take it?

Hi Jon,

Yes, can you take this through your tree?

You can add:

 Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>


Thanks!

-- Steve
