Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC651EEA5F;
	Mon, 20 Jan 2025 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737417185; cv=none; b=OugEVVL25tx8F6AP1ZPkApc5lXqwwhjT29vyx8KgtE2DK84qCu6CoDYkQCqXHhsiBs5lQHGux0sgD3/zmynhkAFsbRfz2OdphmKaJTNhhXMgOPF6HYDTSKl3ohc5u6BH900wyEUFjDJAU2pkabsfgc/j5a2Q3Kd1AN7Obd7j+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737417185; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:From:To; b=mWpsEW0eDAvBvdqYZHoG79qlB3tAwZ0qtXvFRLKBWwh2ULtgJrxVPWEZx63aL0p4l+rg+vH51vQtQJeSKUfj2i1xglRnk5oNJzaetr51p8zQNc1H2qasEKxucZmzIDpAMbTVC5PsiCJC+jWtIHgZRHvTRZRkhh+F41IuOZHaffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47B1C4CEE3;
	Mon, 20 Jan 2025 23:53:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1ta1Zq-0000000092P-2kkp;
	Mon, 20 Jan 2025 18:53:06 -0500
Message-ID: <20250120235306.506894746@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 20 Jan 2025 18:40:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

