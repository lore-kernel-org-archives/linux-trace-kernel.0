Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA48466B7B;
	Thu,  4 Jun 2026 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577099; cv=none; b=A9rkAJZC274dIFJVtCO8q3nk+h/w2+GBXABY4UlvqRa/qVLm+gCUqiWrqHXQtRPJcBzmEE++NqSs7vm/TYPtgIjLs72uYTOFOVmmwD32eJkrItV2L1JC4TUE4xLhtkRjvgGtrwpR0uQ71EZgnrkCmQqkuXTGPSrdvVrky3XTGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577099; c=relaxed/simple;
	bh=p8OduhigYazK6aOGZN4DbVjz8PfwSDjucx3RfPOQl28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ju0fZ0WbuetZFEOa2ItBwTq9ir7zO7KU5GGsi//Yl33uqKLY9bSKc7CQLTR372/yGaH9a8kXoNaRGinZkL5f700E/sbiX3hB+5u5Hssr8nuufDpnMfbaKYNmOGe/+RC2biWoAsfjCy7ol/Uulm0x0gsk8k00Zap1Fvz6lKo57Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 85B408FF1C;
	Thu,  4 Jun 2026 12:44:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id BBD002002C;
	Thu,  4 Jun 2026 12:44:54 +0000 (UTC)
Date: Thu, 4 Jun 2026 08:44:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, unknownbbqrx <dev@unknownbbqr.xyz>, Wen
 Yang <wen.yang@linux.dev>
Subject: Re: [GIT PULL] rv fixes for v7.1
Message-ID: <20260604084452.4d41e173@fedora>
In-Reply-To: <CAP4=nvQEF7BtsMSoDaVO+5MazsRGypUnxB8w0Uq=2sCy=g2HGw@mail.gmail.com>
References: <20260603125056.75559-1-gmonaco@redhat.com>
	<20260603191627.5cb4ef6c@fedora>
	<CAP4=nvQEF7BtsMSoDaVO+5MazsRGypUnxB8w0Uq=2sCy=g2HGw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sizhf3oofhhownwbz19kz9ujdf9pwkta
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: BBD002002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19GWwrQyYhBNlAh15VnqR0qlsYAjohbexU=
X-HE-Tag: 1780577094-593141
X-HE-Meta: U2FsdGVkX19eJKqIXbxfaqAepMVThIGpO9nRYrtnjLxXav+d8xBtVFvMKf0H69NPYQK5EAyjVzeLCUV7rQym2a98Lm93S1HLFtqT5j5Xum+kNxMh8TdN5Ua/+hf04I5tyDklm7mEhl075Y90aI7IKkpJwSKN1Q8QiKVe0JEBMmzOBYk4DZvTrTmEIpPZG8hTcYkZcdqQEXKSwsw2QJziXqLrMQb8Ru/mcJR6xmUkLCIrRDGXyi0B/TiemL3OrOQJRv45OcKQJPOaoXaNxEKoQTm1nOwAvAq9luNSkxVNrSeZFakgdHyYzdDormrYcoApKheP9PGtMh8yyxUULHC8z+TDfrUWflyu

On Thu, 4 Jun 2026 13:32:46 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> Is this really still the case? Note that the document says:
> 
> "using a known identity (sorry, no anonymous contributions.)"
> 
> It really used to say "real name", but it was changed by Linus in 2023
> [1]. Note especially this section by Linus:
> 
> " It was 2006, and nobody reacted to the wording, the whole Facebook 'real
>    name' controversy was a decade in the future, and nobody even thought
>    about it.  And despite the language, we've always accepted nicknames and
>    that language was never meant to be any kind of exclusionary wording."
> 
> The wording sounds quite clear to me. And I'm certain that there were
> contributions under pseudonymous identity that have been accepted
> since then, most famously by Asahi Lina, a vtuber persona [2]. I don't
> really see a difference between that and "unknownbbqrx", other than
> the latter doesn't sound like a real name.

It specifically says "using a known identity (sorry, no anonymous contributions.)"

As you said, Asahi Lina is well known and a very "known identity".
"unknownbbqrx" is unknown and even states it in the name.

I will not personally accept such a submission, as the Signed-off-by is
a legal statement that states you have the right to submit that code
and take all responsibility for it.

-- Steve
