Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6414A3846;
	Thu,  3 Sep 2026 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453309; cv=none; b=K6iS1LGP7WVxwS/XX1yoSyT6OVlUrtMZp0clqSHc1CcvPeVO36JMs4tvMjWg/Td2UCL1w71z65HuzXxSQ01eXAyx06tKKdZejaBPReZzFJfijp4+DOUSC5NU8QufQj9IVXW9EN0yPhBKHvskYehbi8W8SFiii7d4c1FL8OOd9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453309; c=relaxed/simple;
	bh=k5ro6TI+X/hlymQmTV2S9JypG6xvQdKKh4M6ScuMPnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCGlrjhI1tBYYWtaX9F/sUGei7zBlAG3vE787OJIRfGTNo41vFo3l2nACEXnrbxUn4K8yg8zcby+639hGS2FD0tQlKhbZLVw8a/b440BASE4JG7N4oHWez8tYpUWAzfVRZ/c9OGLgHbmSY7XdjIjgAS5eXNJfNY7FWimlXo3QDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=2sHoeePs; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="2sHoeePs"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 7984D1205B5;
	Thu,  3 Sep 2026 16:35:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 8BF1120024;
	Thu,  3 Sep 2026 16:35:03 +0000 (UTC)
Date: Thu, 3 Sep 2026 12:36:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peng Donglin <dolinux.peng@gmail.com>, dolinux.peng@gmai.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v5 0/3] Use BTF to trim return values
Message-ID: <20260903123606.6e5bc37e@gandalf.local.home>
In-Reply-To: <20260902235533.ea387f764b51b1b2a8ce8224@kernel.org>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
	<20260901135715.4812fde9@gandalf.local.home>
	<f18beeb4-f3df-41eb-9990-5be295a2729b@gmail.com>
	<20260902235533.ea387f764b51b1b2a8ce8224@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8BF1120024
X-Stat-Signature: 57epuggdoh1mos475afbm1jya1y4p5ho
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JigZdIexYP6SmyGbKpHXWh81XpwpiShk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=v2fYFgHItsVJon5i4uqh44uE7r6moAwhyEs99h7vg+M=; b=2sHoeePsCbrdhe8t7BBqtKAJCRQBr7SVJoO4yJdM2fQWMdfGncV9TeYpT+Et78BJWt2CoW9LIC0m8estZa1vPFiVEYPC9gX04bUKCvwSqiqu2gBjnCghcaH+AjeB0EiE5YI5wY2iUiZ5DvQuR6sV6KRC7I/UTeqVFkMvgg6+Nag=
X-HE-Tag: 1788453303-2937
X-HE-Meta: U2FsdGVkX1+gVgNAc60hA4xDTsJpfHncZMbeSDm+R/BoC4VSvdZGvHmuTlxeFP/BUc6WWmaL+sYD+L5IqyJ3rX7ncuDnln0FGjx5F++54wmAthiq+tLPNqtpX4A7cDabnttvC3UyFAR09maikr9URPFUMIX1C4e0WzgTkHhfn+8bHnVwoebhE/Gm7OYIVCfF9PflQhPxmyPiRPy6EKH3Rb3Jj6ZV4v3LywaQULNr8IoMD1giuWI3PfU5I5uRc58rCz9ogfzV0GqBkLKID36tZeiYOlH2X/vQ8NPEShMaFbhCCy3Bv40pwzE48ZstGBBhYPq+x1cp0UD8WGe3dJEAFcYjW2jCFHFZ

On Wed, 2 Sep 2026 23:55:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm, shouldn't both the actually applied size and the true size be displayed?
> e.g.
> 
> ret=0x5 (in 8 bytes, true size: 16 bytes)

I have to ask. Why do we care? Is there a use for this information?

If not, ret=0x5 would be sufficient.

-- Steve
