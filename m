Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF33433B6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705249; cv=none; b=u0DO32aKAeKqeFZhvWjSN+QuRlDR0DvZNPzsFVJyu0e3bIvFVNB0XLVXNciVhu8rJPkkOAAvKRYHGol3KRAbnhZadYPS5ycFceHyJ7v7FnWyh1jxjZoyaK2QursqqEM7aoL/J1wEN9kfeNYVFqG7FnhdMi15yUPMPOF58xVtdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705249; c=relaxed/simple;
	bh=MQgQ5Y+wyV7M+P7cn+6b2fe9xs8I8tLEPHAixmPTGLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WycvS4CM2M77n//cwEofgHfJRAbDa4aQ8nMUwj95yN5cxSI9aMYI2Aw4i2L8wism8A1VL8Bxn3B6tlNfD6BSmHooYl2Hr86uOXDouBRbGRZrwgn2d3bgAiRCJ5WbXNJV1VGrzv65OoSgCMVlw5D4qC0hTX8j1G4VFAHzQA704Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BCBC4CEC7;
	Mon, 30 Sep 2024 14:07:28 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: furkanonder <furkanonder@protonmail.com>
Cc: Clark Williams <williams@redhat.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/timerlat: Enhance Error Handling and Readability
 for timerlat_load.py
Message-ID: <20240930100814.7635e21e@gandalf.local.home>
In-Reply-To: <NPl8CXZesS-2Yga8ePwiOTlriUFANh7fZqkSvuHS4wL7AOEGoQ7OYcm-QozD4jffDJ68Bd11N9GQBaOnhT4Iq55T4hWEML-kvNbHMkUlfc8=@protonmail.com>
References: <2eV3oMRbTimO2AnpsTNrv5qQFnWBqljnkXxLciVNWDGDWP4rTQS1nfvRZAsJ9-Mx9U9GsxMyQZ5UZ94FSBjZrFeuJHKloPzE45D3k-3LnIA=@protonmail.com>
	<20240926003823.50a14245@rorschach.local.home>
	<NPl8CXZesS-2Yga8ePwiOTlriUFANh7fZqkSvuHS4wL7AOEGoQ7OYcm-QozD4jffDJ68Bd11N9GQBaOnhT4Iq55T4hWEML-kvNbHMkUlfc8=@protonmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 29 Sep 2024 23:21:05 +0000
furkanonder <furkanonder@protonmail.com> wrote:

> I=E2=80=99m sorry; I included the patch as an attachment in the email wit=
hout noticing.

Yes, but still, you need to have the patch with the change log and the
signed-off-by. Not as a separate email.

Try using "git send-email", that can probably help.

-- Steve
